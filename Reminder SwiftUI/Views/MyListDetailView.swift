import SwiftUI

struct MyListDetailView: View {

    let myList: MyList
    @State private var openAddReminder = false
    @State private var title = ""

    @FetchRequest(sortDescriptors: [])
    private var remindersResults: FetchedResults<Reminder>

    private var isFormValid: Bool {
        !title.isEmpty
    }

    init(myList: MyList) {
        self.myList = myList
        _remindersResults = FetchRequest(fetchRequest: ReminderService.getRemindersByList(myList: myList))
    }

    var body: some View {
        VStack {
            ReminderListView(reminders: remindersResults)
            HStack {
                Image(systemName: "plus.circle.fill")
                Button("Novo lembrete") {
                    openAddReminder = true
                }
            }.foregroundColor(.blue)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
        }.alert("Novo lembrete", isPresented: $openAddReminder) {
            TextField("", text: $title)
            Button("Cancelar", role: .cancel) {}
            Button("Salvar") {
                if isFormValid {
                    do {
                        try ReminderService.saveReminderToMyList(myList: myList, reminderTitle: title)
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }
        }
    }
}

#Preview {
    MyListDetailView(myList: PreviewData.myList)
}
