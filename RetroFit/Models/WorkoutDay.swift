import Foundation
import SwiftData

@Model
final class WorkoutDay {
    var dayOfWeekRaw: Int
    var modeRaw: String

    @Relationship(deleteRule: .cascade, inverse: \Exercise.day)
    var exercises: [Exercise] = []

    var dayOfWeek: DayOfWeek {
        get { DayOfWeek(rawValue: dayOfWeekRaw) ?? .monday }
        set { dayOfWeekRaw = newValue.rawValue }
    }

    var mode: WorkoutMode {
        get { WorkoutMode(rawValue: modeRaw) ?? .strength }
        set { modeRaw = newValue.rawValue }
    }

    init(dayOfWeek: DayOfWeek, mode: WorkoutMode = .strength) {
        self.dayOfWeekRaw = dayOfWeek.rawValue
        self.modeRaw = mode.rawValue
    }

    func exercises(for section: ExerciseSection) -> [Exercise] {
        exercises
            .filter { $0.sectionRaw == section.rawValue }
            .sorted { $0.sortOrder < $1.sortOrder }
    }

    var hasExercises: Bool {
        !exercises.isEmpty
    }
}
