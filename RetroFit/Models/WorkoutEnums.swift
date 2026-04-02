import Foundation

enum DayOfWeek: Int, Codable, CaseIterable, Identifiable {
    case monday = 0
    case tuesday = 1
    case wednesday = 2
    case thursday = 3
    case friday = 4
    case saturday = 5
    case sunday = 6

    var id: Int { rawValue }

    var shortName: String {
        switch self {
        case .monday: return "Mon"
        case .tuesday: return "Tue"
        case .wednesday: return "Wed"
        case .thursday: return "Thu"
        case .friday: return "Fri"
        case .saturday: return "Sat"
        case .sunday: return "Sun"
        }
    }

    var fullName: String {
        switch self {
        case .monday: return "Monday"
        case .tuesday: return "Tuesday"
        case .wednesday: return "Wednesday"
        case .thursday: return "Thursday"
        case .friday: return "Friday"
        case .saturday: return "Saturday"
        case .sunday: return "Sunday"
        }
    }

    var initial: String {
        switch self {
        case .monday: return "M"
        case .tuesday: return "T"
        case .wednesday: return "W"
        case .thursday: return "T"
        case .friday: return "F"
        case .saturday: return "S"
        case .sunday: return "S"
        }
    }
}

enum WorkoutMode: String, Codable, CaseIterable {
    case strength = "Strength"
    case cardio = "Cardio"
    case mobility = "Mobility"

    var systemIcon: String {
        switch self {
        case .strength: return "dumbbell.fill"
        case .cardio: return "figure.run"
        case .mobility: return "figure.cooldown"
        }
    }

    var shortLabel: String {
        switch self {
        case .strength: return "Lift"
        case .cardio: return "Cardio"
        case .mobility: return "Stretch"
        }
    }

    var pickerLabel: String {
        switch self {
        case .strength: return "Lift"
        case .cardio: return "Cardio"
        case .mobility: return "Stretch"
        }
    }

    var statsLabel: String {
        switch self {
        case .strength: return "Lift"
        case .cardio: return "Card"
        case .mobility: return "Mob"
        }
    }
}

enum ExerciseSection: Int, Codable, CaseIterable, Identifiable {
    case warmup = 0
    case main = 1
    case cooldown = 2

    var id: Int { rawValue }

    var label: String {
        switch self {
        case .warmup: return "Warmup"
        case .main: return "Workout"
        case .cooldown: return "Cooldown"
        }
    }

    var systemIcon: String {
        switch self {
        case .warmup: return "flame"
        case .main: return "figure.strengthtraining.traditional"
        case .cooldown: return "wind"
        }
    }
}

enum Intensity: String, Codable, CaseIterable, Identifiable {
    case low = "Low"
    case moderate = "Moderate"
    case high = "High"
    case max = "Max"

    var id: String { rawValue }
}
