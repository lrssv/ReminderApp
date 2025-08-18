import Foundation
import SwiftUI

struct ReminderStatsValues {
    
    var todayCount = 0
    var scheduledCount = 0
    var allCount = 0
    var completedCount = 0
}

struct ReminderStatsBuilder {
    
    func build(myListResult: FetchedResults<MyList>) -> ReminderStatsValues {
        let reminders = myListResult.map {
            $0.remindersArray
        }.reduce([], +)
        
        let todayCount = calculateTodayCount(reminder: reminders)
        let scheduledCount = calculateScheduledCount(reminder: reminders)
        let allCount = calculateAllCount(reminder: reminders)
        let completedCount = calculateCompletedCount(reminder: reminders)
        
        return .init(todayCount: todayCount, scheduledCount: scheduledCount, allCount: allCount, completedCount: completedCount)
    }
    
    private func calculateTodayCount(reminder: [Reminder]) -> Int {
        return reminder.reduce(0) { result, reminder in
            let isToday = reminder.reminderDate?.isToday ?? false
            return isToday ? result + 1 : result
        }
    }
    
    private func calculateScheduledCount(reminder: [Reminder]) -> Int {
        return reminder.reduce(0) { result, reminder in
            let hasDate = reminder.reminderDate != nil
            let hasTime = reminder.reminderTime != nil
            return (hasDate || hasTime) && !reminder.isCompleted ? result + 1 : result
        }
    }
    
    private func calculateAllCount(reminder: [Reminder]) -> Int {
        return reminder.reduce(0) { result, reminder in
            return !reminder.isCompleted ? result + 1 : result
        }
    }
    
    private func calculateCompletedCount(reminder: [Reminder]) -> Int {
        return reminder.reduce(0) { result, reminder in
            return reminder.isCompleted ? result + 1 : result
        }
    }
}
