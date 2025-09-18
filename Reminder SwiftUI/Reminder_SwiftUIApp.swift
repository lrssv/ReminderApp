import SwiftUI

@main
struct Reminder_SwiftUIApp: App {

    init() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { _, _ in }
    }
    
    var body: some Scene {
        WindowGroup {
            HomeView().environment(
                \.managedObjectContext,
                 CoreDataProvider.shared.persistentContainer.viewContext
            )
        }
    }
}
