import SwiftUI

struct ReminderListView: View {

    let reminders: FetchedResults<Reminder>

    var body: some View {
        List(reminders) { reminder in
            ReminderCellView(reminder: reminder) { event in
                switch event {
                case .onInfo:
                    print("onInfo")
                case .onCheckedChange(let reminder):
                    print("onCheckedChange")
                case .onSelect(let reminder):
                    print("onSelect")
                }
            }
        }
    }
}
