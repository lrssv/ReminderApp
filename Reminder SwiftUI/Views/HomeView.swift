import SwiftUI

struct HomeView: View {
    
    @FetchRequest(sortDescriptors: [])
    private var myListResults: FetchedResults<MyList>
    
    @FetchRequest(sortDescriptors: [])
    private var searchResults: FetchedResults<Reminder>
    
    @State private var search: String = ""
    @State private var isPresented: Bool = false
    @State private var searching: Bool = false
    
    private var reminderStatsBuilder = ReminderStatsBuilder()
    @State private var reminderStatsValues = ReminderStatsValues()
    
    var body: some View {
        NavigationStack {
            VStack {
                ScrollView {
                    HStack {
                        ReminderStatsView(
                            icon: "calendar",
                            title: "Hoje",
                            count: reminderStatsValues.todayCount
                        )
                        ReminderStatsView(
                            icon: "tray.circle.fill",
                            title: "Total",
                            count: reminderStatsValues.allCount
                        )
                    }
                    
                    HStack {
                        ReminderStatsView(
                            icon: "calendar.circle.fill",
                            title: "Agendado",
                            count: reminderStatsValues.scheduledCount
                        )
                        ReminderStatsView(
                            icon: "tray.circle.fill",
                            title: "Finalizado",
                            count: reminderStatsValues.completedCount
                        )
                    }
                    
                    Spacer(minLength: 40)
                    
                    Text("Minhas listas")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.largeTitle)
                        .bold()
                        .padding()
                    
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
            .onAppear {
                reminderStatsValues = reminderStatsBuilder.build(myListResult: myListResults)
            }
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
