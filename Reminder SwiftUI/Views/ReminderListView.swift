import SwiftUI

struct ReminderListView: View {

    let reminders: FetchedResults<Reminder>

    private func reminderCheckedChanged(_ reminder: Reminder, _ isCompleted: Bool) {
        var editConfig = ReminderEditConfig(reminder: reminder)
        editConfig.isCompleted = isCompleted
        do {
            let _ = try ReminderService.updateReminder(reminder: reminder, editConfig: editConfig)
        } catch {
            print(error)
        }
    }

    var body: some View {
        List(reminders) { reminder in
            ReminderCellView(reminder: reminder) { event in
                switch event {
                case .onInfo:
                    print("onInfo")
                case .onCheckedChange(let reminder, let isCompleted):
                    reminderCheckedChanged(reminder, isCompleted)
                case .onSelect(let reminder):
                    print("onSelect")
                }
            }
        }
    }
}
