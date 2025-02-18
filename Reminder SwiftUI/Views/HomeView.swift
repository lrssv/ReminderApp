import SwiftUI

struct HomeView: View {

    @State private var isPresented: Bool = false

    var body: some View {
        NavigationStack {
            VStack {
                Text("Hello world")
                Spacer()
                Button {
                    isPresented = true
                } label: {
                    Text("Adicionar lista")
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .font(.headline)
                }.padding()
            }.sheet(isPresented: $isPresented) {
                NavigationView {
                    AddNewListView { name, color in
                        do {
                            try ReminderService.saveMyList(name, color)
                        } catch {
                            print(error)
                        }
                    }
                }
            }
        }
        .padding()
    }
}

#Preview {
    HomeView().environment(
        \.managedObjectContext,
         CoreDataProvider.shared.persistentContainer.viewContext
    )
}
