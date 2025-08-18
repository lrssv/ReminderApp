import SwiftUI

struct HomeView: View {
    
    @FetchRequest(sortDescriptors: [])
    private var myListResults: FetchedResults<MyList>
    
    @FetchRequest(sortDescriptors: [])
    private var searchResults: FetchedResults<Reminder>
    
    @State private var search: String = ""
    @State private var isPresented: Bool = false
    @State private var searching: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack {
                ScrollView {
                    Spacer(minLength: 20)
                    
                    MyListsView(myLists: myListResults)
                    
                    Button {
                        isPresented = true
                    } label: {
                        Text("Adicionar lista")
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .font(.headline)
                    }.padding()
                }
            }
            .onChange(of: search, { _, searchTerm in
                searching = !searchTerm.isEmpty
                searchResults.nsPredicate = ReminderService.getReminderByText(searchTerm).predicate
            })
            .overlay(alignment: .center, content: {
                ReminderListView(reminders: searchResults).opacity(searching ? 1 : 0)
            })
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .sheet(isPresented: $isPresented) {
                NavigationView {
                    AddNewListView { name, color in
                        do {
                            try ReminderService.saveMyList(name, color)
                        } catch {
                            print(error)
                        }
                    }
                }
            }.listStyle(.plain)
             .padding()
             .navigationTitle("Lembretes")
        }.searchable(text: $search)
    }
}

#Preview {
    HomeView().environment(
        \.managedObjectContext,
         CoreDataProvider.shared.persistentContainer.viewContext
    )
}
