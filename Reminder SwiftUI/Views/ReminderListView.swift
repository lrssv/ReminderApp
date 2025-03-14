import SwiftUI

struct ReminderListView: View {

    let reminders: FetchedResults<Reminder>

    var body: some View {
        List(reminders) { reminder in
            Text(reminder.title ?? "")
        }
    }
}
