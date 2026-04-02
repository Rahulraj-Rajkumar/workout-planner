import Foundation

enum DateHelpers {
    static func startOfCurrentWeek() -> Date {
        let calendar = Calendar.current
        let today = Date()
        let weekday = calendar.component(.weekday, from: today)
        // Adjust so Monday = start of week (Calendar Sunday=1, Monday=2)
        let daysFromMonday = (weekday + 5) % 7
        return calendar.date(byAdding: .day, value: -daysFromMonday, to: calendar.startOfDay(for: today))!
    }

    static func dayOfWeekFromDate(_ date: Date) -> DayOfWeek {
        let weekday = Calendar.current.component(.weekday, from: date)
        switch weekday {
        case 2: return .monday
        case 3: return .tuesday
        case 4: return .wednesday
        case 5: return .thursday
        case 6: return .friday
        case 7: return .saturday
        case 1: return .sunday
        default: return .monday
        }
    }
}
