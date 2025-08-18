import Foundation
import CoreData

@objc(MyList)
public class MyList: NSManagedObject, Identifiable {
    
    var remindersArray: [Reminder] {
        reminders?.allObjects.compactMap { $0 as? Reminder } ?? []
    }
}
