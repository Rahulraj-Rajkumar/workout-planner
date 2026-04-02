import SwiftUI

struct WeekView: View {
    @Binding var selectedDay: DayOfWeek
    let workoutDays: [WorkoutDay]

    var body: some View {
        HStack(spacing: 8) {
            ForEach(DayOfWeek.allCases) { day in
                let isSelected = selectedDay == day
                let dayData = workoutDays.first { $0.dayOfWeek == day }
                let hasExercises = dayData?.hasExercises ?? false
                let accent = dayData.map { RetroTheme.modeColor($0.dominantMode) } ?? RetroTheme.warmGray

                Button {
                    withAnimation(.easeInOut(duration: 0.15)) {
                        selectedDay = day
                    }
                } label: {
                    VStack(spacing: 6) {
                        Text(day.shortName.uppercased())
                            .font(RetroTheme.smallFont.weight(.bold))
                            .tracking(1)

                        Circle()
                            .fill(hasExercises ? accent : RetroTheme.lightGray.opacity(0.25))
                            .frame(width: 7, height: 7)
                    }
                    .frame(maxWidth: .infinity)
                    .frame(minHeight: 52)
                    .foregroundStyle(isSelected ? RetroTheme.paperBase : RetroTheme.inkBlack)
                    .background(
                        RoundedRectangle(cornerRadius: 12, style: .continuous)
                            .fill(
                                isSelected
                                    ? AnyShapeStyle(RetroTheme.selectedDayGradient(accent))
                                    : AnyShapeStyle(RetroTheme.cardGradient)
                            )
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 12, style: .continuous)
                            .strokeBorder(
                                isSelected ? accent.opacity(0.7) : RetroTheme.borderLight,
                                lineWidth: isSelected ? 1.5 : 1
                            )
                    )
                    .shadow(
                        color: isSelected ? accent.opacity(0.18) : RetroTheme.shadowBrown.opacity(0.08),
                        radius: 8,
                        x: 0,
                        y: 5
                    )
                }
                .buttonStyle(.plain)
                .accessibilityLabel(day.fullName)
                .accessibilityValue(
                    hasExercises
                        ? "\(dayData?.exerciseCount ?? 0) exercises"
                        : "No exercises"
                )
                .accessibilityHint(isSelected ? "Currently selected" : "Show \(day.fullName)'s plan")
            }
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 10)
    }
}
