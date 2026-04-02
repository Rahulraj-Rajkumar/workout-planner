import SwiftUI

struct WeekView: View {
    @Binding var selectedDay: DayOfWeek
    let workoutDays: [WorkoutDay]

    var body: some View {
        HStack(spacing: 4) {
            ForEach(DayOfWeek.allCases) { day in
                let isSelected = selectedDay == day
                let dayData = workoutDays.first { $0.dayOfWeek == day }
                let hasExercises = dayData?.hasExercises ?? false

                Button {
                    withAnimation(.easeInOut(duration: 0.15)) {
                        selectedDay = day
                    }
                } label: {
                    VStack(spacing: 4) {
                        Text(day.shortName)
                            .font(RetroTheme.smallFont)
                            .fontWeight(isSelected ? .bold : .regular)

                        // Activity dot
                        Circle()
                            .fill(hasExercises
                                ? (dayData.map { RetroTheme.modeColor($0.mode) } ?? RetroTheme.warmGray)
                                : Color.clear)
                            .frame(width: 5, height: 5)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 10)
                    .foregroundStyle(isSelected ? RetroTheme.cream : RetroTheme.inkBlack)
                    .background(
                        isSelected
                            ? RetroTheme.borderBrown
                            : RetroTheme.cream
                    )
                    .clipShape(RoundedRectangle(cornerRadius: RetroTheme.cornerRadius))
                    .overlay(
                        RoundedRectangle(cornerRadius: RetroTheme.cornerRadius)
                            .strokeBorder(
                                isSelected ? RetroTheme.borderBrown : RetroTheme.borderLight,
                                lineWidth: isSelected ? RetroTheme.borderWidth : RetroTheme.thinBorder
                            )
                    )
                }
                .buttonStyle(.plain)
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
    }
}
