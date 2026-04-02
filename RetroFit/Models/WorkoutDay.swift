import Foundation
import SwiftData

@Model
final class WorkoutDay {
    @Attribute(.unique)
    var dayOfWeekRaw: Int
    var defaultModeRaw: String

    @Relationship(deleteRule: .cascade, inverse: \Exercise.day)
    var exercises: [Exercise] = []

    var dayOfWeek: DayOfWeek {
        get { DayOfWeek(rawValue: dayOfWeekRaw) ?? .monday }
        set { dayOfWeekRaw = newValue.rawValue }
    }

    var defaultMode: WorkoutMode {
        get { WorkoutMode(rawValue: defaultModeRaw) ?? .strength }
        set { defaultModeRaw = newValue.rawValue }
    }

    var dominantMode: WorkoutMode {
        guard !exercises.isEmpty else { return defaultMode }

        let counts = Dictionary(grouping: exercises, by: \.mode).mapValues(\.count)
        let highestCount = counts.values.max() ?? 0
        let dominantModes = WorkoutMode.allCases.filter { counts[$0, default: 0] == highestCount }

        if dominantModes.count != 1 {
            return defaultMode
        }

        return dominantModes[0]
    }

    var exerciseCount: Int {
        exercises.count
    }

    init(dayOfWeek: DayOfWeek, defaultMode: WorkoutMode = .strength) {
        self.dayOfWeekRaw = dayOfWeek.rawValue
        self.defaultModeRaw = defaultMode.rawValue
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
