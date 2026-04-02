import SwiftUI
import SwiftData

@main
@MainActor
struct RetroFitApp: App {
    private let sharedModelContainer: ModelContainer

    init() {
        do {
            sharedModelContainer = try ModelContainer(for: WorkoutDay.self, Exercise.self)
            seedWorkoutDaysIfNeeded(in: sharedModelContainer.mainContext)
        } catch {
            fatalError("Failed to set up model container: \(error)")
        }
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }

    private func seedWorkoutDaysIfNeeded(in context: ModelContext) {
        let descriptor = FetchDescriptor<WorkoutDay>(sortBy: [SortDescriptor(\.dayOfWeekRaw)])
        let existingDays = Set((try? context.fetch(descriptor))?.map(\.dayOfWeekRaw) ?? [])

        var insertedDay = false
        for day in DayOfWeek.allCases where !existingDays.contains(day.rawValue) {
            context.insert(WorkoutDay(dayOfWeek: day))
            insertedDay = true
        }

        if insertedDay {
            try? context.save()
        }
    }
}
