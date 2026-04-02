import Foundation
import SwiftData

enum SampleData {
    @MainActor
    static func createSampleContainer() -> ModelContainer {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try! ModelContainer(
            for: WorkoutDay.self, Exercise.self,
            configurations: config
        )

        DayOfWeek.allCases.forEach { day in
            container.mainContext.insert(WorkoutDay(dayOfWeek: day))
        }

        let days = try! container.mainContext.fetch(FetchDescriptor<WorkoutDay>())
        let monday = days.first { $0.dayOfWeek == .monday }!
        monday.defaultMode = .strength

        let warmup1 = Exercise(name: "Shoulder Flow", section: .warmup, mode: .mobility, sortOrder: 0, durationMinutes: 5)
        warmup1.day = monday

        let bench = Exercise(name: "Bench Press", section: .main, mode: .strength, sortOrder: 0, sets: 4, reps: 8, weight: 135)
        bench.day = monday

        let rows = Exercise(name: "Barbell Row", section: .main, mode: .strength, sortOrder: 1, sets: 3, reps: 10, weight: 95)
        rows.day = monday

        let stretch = Exercise(name: "Hip Flexor Stretch", section: .cooldown, mode: .mobility, sortOrder: 0, durationMinutes: 10)
        stretch.day = monday

        [warmup1, bench, rows, stretch].forEach {
            container.mainContext.insert($0)
        }

        let wednesday = days.first { $0.dayOfWeek == .wednesday }!
        wednesday.defaultMode = .cardio

        let run = Exercise(name: "Treadmill Run", section: .main, mode: .cardio, sortOrder: 0, durationMinutes: 30, distanceKm: 5, intensity: .moderate)
        run.day = wednesday
        container.mainContext.insert(run)

        return container
    }
}
