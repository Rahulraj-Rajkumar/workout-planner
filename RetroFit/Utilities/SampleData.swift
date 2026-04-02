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

        let monday = WorkoutDay(dayOfWeek: .monday, mode: .strength)
        container.mainContext.insert(monday)

        let warmup1 = Exercise(name: "Jumping Jacks", section: .warmup, sortOrder: 0, durationMinutes: 5)
        warmup1.day = monday

        let bench = Exercise(name: "Bench Press", section: .main, sortOrder: 0, sets: 4, reps: 8, weight: 135)
        bench.day = monday

        let rows = Exercise(name: "Barbell Row", section: .main, sortOrder: 1, sets: 3, reps: 10, weight: 95)
        rows.day = monday

        let stretch = Exercise(name: "Static Stretch", section: .cooldown, sortOrder: 0, durationMinutes: 10)
        stretch.day = monday

        [warmup1, bench, rows, stretch].forEach {
            container.mainContext.insert($0)
        }

        let wednesday = WorkoutDay(dayOfWeek: .wednesday, mode: .cardio)
        container.mainContext.insert(wednesday)

        let run = Exercise(name: "Treadmill Run", section: .main, sortOrder: 0, durationMinutes: 30, distanceKm: 5, intensity: .moderate)
        run.day = wednesday
        container.mainContext.insert(run)

        return container
    }
}
