import SwiftUI

struct ReminderDetailView: View {

    @Binding var reminder: Reminder
    @State var editConfig = ReminderEditConfig()

    var body: some View {
        NavigationView {
            VStack {
                List {
                    Section {
                        TextField("Titulo", text: $editConfig.title)
                        TextField("Notas", text: $editConfig.notes ?? "")
                    }
                    Section {
                        Toggle(isOn: $editConfig.hasDate) {
                            Image(systemName: "calendar")
                                .foregroundColor(.red)
                        }

                        if editConfig.hasDate {
                            DatePicker("Selecione a data", selection: $editConfig.reminderDate ?? Date(), displayedComponents: .date)
                        }

                        Toggle(isOn: $editConfig.hasTime) {
                            Image(systemName: "clock")
                                .foregroundColor(.blue)
                        }

                        if editConfig.hasTime {
                            DatePicker("Selecione a hora", selection: $editConfig.reminderTime ?? Date(), displayedComponents: .hourAndMinute)
                        }

                        Section {
                            NavigationLink {
                                SelectListView(selectList: $reminder.list)
                            } label: {
                                HStack {
                                    Text("Lista")
                                    Spacer()
                                    Text(reminder.list!.name)
                                }
                            }
                        }
                    }
                }.listStyle(.insetGrouped)
            }.onAppear {
                editConfig = ReminderEditConfig(reminder: reminder)
            }
        }
    }
}

#Preview {
    ReminderDetailView(reminder: .constant(PreviewData.reminder))
}
