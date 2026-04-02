import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var workoutDays: [WorkoutDay]
    @State private var selectedDay: DayOfWeek = currentDayOfWeek()

    var body: some View {
        VStack(spacing: 0) {
            // App header
            appHeader()

            // Retro divider
            Rectangle()
                .fill(RetroTheme.borderBrown)
                .frame(height: 2)

            // Week day picker
            WeekView(selectedDay: $selectedDay, workoutDays: workoutDays)

            // Thin divider
            Rectangle()
                .fill(RetroTheme.borderLight)
                .frame(height: 1)
                .padding(.horizontal, 16)

            // Day detail
            let dayData = workoutDays.first { $0.dayOfWeek == selectedDay }
            if let day = dayData {
                DayDetailView(workoutDay: day)
            } else {
                emptyDayView()
            }
        }
        .background(RetroTheme.cream)
        .onAppear { ensureDayExists(selectedDay) }
        .onChange(of: selectedDay) { _, newDay in
            ensureDayExists(newDay)
        }
    }

    @ViewBuilder
    private func appHeader() -> some View {
        HStack(spacing: 10) {
            // Retro Apple-inspired logo
            VStack(spacing: 1) {
                ForEach([
                    RetroTheme.retroGreen,
                    RetroTheme.retroYellow,
                    RetroTheme.retroOrange,
                    RetroTheme.retroRed,
                    RetroTheme.retroPurple,
                    RetroTheme.retroBlue
                ], id: \.self) { color in
                    Rectangle()
                        .fill(color)
                        .frame(width: 16, height: 3)
                }
            }

            Text("RetroFit")
                .font(.system(.title, design: .monospaced))
                .fontWeight(.bold)
                .foregroundStyle(RetroTheme.inkBlack)

            Spacer()

            Text("v1.0")
                .font(RetroTheme.smallFont)
                .foregroundStyle(RetroTheme.warmGray)
                .padding(.horizontal, 8)
                .padding(.vertical, 3)
                .background(RetroTheme.parchment)
                .clipShape(RoundedRectangle(cornerRadius: 2))
                .overlay(
                    RoundedRectangle(cornerRadius: 2)
                        .strokeBorder(RetroTheme.borderLight, lineWidth: 1)
                )
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(RetroTheme.parchment)
    }

    @ViewBuilder
    private func emptyDayView() -> some View {
        VStack(spacing: 16) {
            Spacer()

            Image(systemName: "calendar.badge.plus")
                .font(.system(size: 40))
                .foregroundStyle(RetroTheme.lightGray)

            Text("Setting up \(selectedDay.fullName)...")
                .font(RetroTheme.bodyFont)
                .foregroundStyle(RetroTheme.warmGray)

            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    private func ensureDayExists(_ day: DayOfWeek) {
        let exists = workoutDays.contains { $0.dayOfWeek == day }
        if !exists {
            let newDay = WorkoutDay(dayOfWeek: day)
            modelContext.insert(newDay)
            try? modelContext.save()
        }
    }

    private static func currentDayOfWeek() -> DayOfWeek {
        let weekday = Calendar.current.component(.weekday, from: Date())
        // Calendar weekday: 1=Sunday, 2=Monday, ... 7=Saturday
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
