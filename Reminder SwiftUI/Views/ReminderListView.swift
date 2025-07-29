import SwiftUI

struct ReminderListView: View {

    @State var selectedReminder: Reminder?
    @State var showReminderDetail: Bool = false
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
    
    private func isReminderSelected(_ reminder: Reminder) -> Bool {
        selectedReminder?.objectID == reminder.objectID
    }
    
    var body: some View {
        VStack {
            List(reminders) { reminder in
                ReminderCellView(
                    reminder: reminder,
                    isSelected: isReminderSelected(reminder)
                ) { event in
                    switch event {
                    case .onInfo:
                        showReminderDetail = true
                    case .onCheckedChange(let reminder, let isCompleted):
                        reminderCheckedChanged(reminder, isCompleted)
                    case .onSelect(let reminder):
                        selectedReminder = reminder
                    }
                }
            }
        }.sheet(isPresented: $showReminderDetail) {
            ReminderDetailView(reminder: Binding($selectedReminder)!)
        }
    }
}
