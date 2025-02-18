import SwiftUI

@main
struct Reminder_SwiftUIApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView().environment(
                \.managedObjectContext,
                 CoreDataProvider.shared.persistentContainer.viewContext
            )
        }
    }
}
