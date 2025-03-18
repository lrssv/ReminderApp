import Foundation

struct ReminderEditConfig {

    var title: String = ""
    var notes: String? = nil
    var isCompleted: Bool = false
    var hasDate: Bool = false
    var hasTime: Bool = false
    var reminderDate: Date?
    var reminderTime: Date?

    init() {}

    init(reminder: Reminder) {
        self.title = reminder.title ?? ""
        self.notes = reminder.notes
        self.isCompleted = reminder.isCompleted
        self.hasDate = reminder.reminderDate != nil
        self.hasTime = reminder.reminderTime != nil
        self.reminderDate = reminder.reminderDate
        self.reminderTime = reminder.reminderTime
    }
}
