import SwiftUI
import SwiftData

@main
struct RetroFitApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [WorkoutDay.self, Exercise.self])
    }
}
