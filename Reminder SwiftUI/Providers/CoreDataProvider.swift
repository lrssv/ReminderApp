import Foundation
import CoreData

class CoreDataProvider {

    static let shared = CoreDataProvider()
    let persistentContainer: NSPersistentContainer

    private init() {
        persistentContainer = NSPersistentContainer(name: "RemindersModel")
        persistentContainer.loadPersistentStores { description, error in
            if let error {
                fatalError("Error initialing RemindersModel \(error)")
            }
        }
    }
}
