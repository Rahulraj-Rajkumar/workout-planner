import SwiftUI
import SwiftData

struct ContentView: View {
    @Query(sort: \WorkoutDay.dayOfWeekRaw) private var workoutDays: [WorkoutDay]
    @State private var selectedDay: DayOfWeek = currentDayOfWeek()

    private var selectedWorkoutDay: WorkoutDay? {
        workoutDays.first { $0.dayOfWeek == selectedDay }
    }

    var body: some View {
        ZStack {
            RetroBackground()
                .ignoresSafeArea()

            VStack(spacing: 0) {
                appHeader()
                    .padding(.horizontal, 14)
                    .padding(.top, 10)

                WeekView(selectedDay: $selectedDay, workoutDays: workoutDays)
                    .padding(.top, 8)

                if let day = selectedWorkoutDay {
                    DayDetailView(workoutDay: day)
                } else {
                    emptyDayView()
                }
            }
        }
    }

    @ViewBuilder
    private func appHeader() -> some View {
        VStack(spacing: 0) {
            HStack(spacing: 12) {
                VStack(alignment: .leading, spacing: 2) {
                    HStack(spacing: 10) {
                        VStack(spacing: 2) {
                            ForEach(RetroTheme.rainbowStripeColors, id: \.self) { color in
                                Rectangle()
                                    .fill(color)
                                    .frame(width: 18, height: 3)
                            }
                        }

                        VStack(alignment: .leading, spacing: 2) {
                            Text("RetroFit")
                                .font(RetroTheme.titleFont)
                                .foregroundStyle(RetroTheme.inkBlack)

                            Text("Simple weekly workout planning")
                                .font(RetroTheme.smallFont)
                                .foregroundStyle(RetroTheme.warmGray)
                                .tracking(0.8)
                        }
                    }
                }

                Spacer(minLength: 12)

                VStack(alignment: .trailing, spacing: 6) {
                    Text("v1.1")
                        .font(RetroTheme.captionFont)
                        .foregroundStyle(RetroTheme.inkBlack)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .background(RetroTheme.insetCream, in: RoundedRectangle(cornerRadius: 6))
                        .overlay(
                            RoundedRectangle(cornerRadius: 6)
                                .strokeBorder(RetroTheme.borderLight, lineWidth: 1)
                        )

                    Text(selectedDay.fullName.uppercased())
                        .font(RetroTheme.smallFont.weight(.bold))
                        .foregroundStyle(RetroTheme.warmGray)
                        .tracking(1.4)
                        .lineLimit(1)
                        .minimumScaleFactor(0.8)
                }
                .frame(width: RetroTheme.appHeaderDayStampWidth, alignment: .trailing)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 14)

            Rectangle()
                .fill(RetroTheme.borderLight.opacity(0.9))
                .frame(height: 1)
        }
        .background(
            RoundedRectangle(cornerRadius: 18, style: .continuous)
                .fill(RetroTheme.chromeGradient)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 18, style: .continuous)
                .strokeBorder(RetroTheme.borderBrown, lineWidth: 1.5)
        )
        .shadow(color: RetroTheme.shadowBrown.opacity(0.18), radius: 12, x: 0, y: 8)
    }

    @ViewBuilder
    private func emptyDayView() -> some View {
        VStack(spacing: 14) {
            Spacer()

            Image(systemName: "calendar.badge.clock")
                .font(.system(size: 42, weight: .regular, design: .rounded))
                .foregroundStyle(RetroTheme.lightGray)

            Text("Loading your week...")
                .font(RetroTheme.bodyFont)
                .foregroundStyle(RetroTheme.warmGray)

            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.horizontal, 24)
    }

    private static func currentDayOfWeek() -> DayOfWeek {
        DateHelpers.dayOfWeekFromDate(Date())
    }
}
