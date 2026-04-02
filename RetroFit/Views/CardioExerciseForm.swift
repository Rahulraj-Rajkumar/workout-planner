import SwiftUI

struct CardioExerciseForm: View {
    @Bindable var exercise: Exercise

    var body: some View {
        HStack(spacing: 12) {
            durationField()

            Text("|")
                .font(RetroTheme.bodyFont)
                .foregroundStyle(RetroTheme.lightGray)

            distanceField()

            Text("|")
                .font(RetroTheme.bodyFont)
                .foregroundStyle(RetroTheme.lightGray)

            intensityPicker()
        }
    }

    private func durationField() -> some View {
        VStack(alignment: .center, spacing: 2) {
            Text("Min")
                .font(RetroTheme.smallFont)
                .foregroundStyle(RetroTheme.warmGray)

            TextField("0", value: Binding(
                get: { exercise.durationMinutes ?? 0 },
                set: { exercise.durationMinutes = $0 }
            ), format: .number)
                .font(RetroTheme.bodyFont)
                .foregroundStyle(RetroTheme.inkBlack)
                .multilineTextAlignment(.center)
                .keyboardType(.decimalPad)
                .frame(width: 44)
                .padding(.vertical, 4)
                .background(RetroTheme.cream)
                .overlay(
                    Rectangle()
                        .frame(height: 1)
                        .foregroundStyle(RetroTheme.borderLight),
                    alignment: .bottom
                )
        }
    }

    private func distanceField() -> some View {
        VStack(alignment: .center, spacing: 2) {
            Text("km")
                .font(RetroTheme.smallFont)
                .foregroundStyle(RetroTheme.warmGray)

            TextField("0", value: Binding(
                get: { exercise.distanceKm ?? 0 },
                set: { exercise.distanceKm = $0 }
            ), format: .number)
                .font(RetroTheme.bodyFont)
                .foregroundStyle(RetroTheme.inkBlack)
                .multilineTextAlignment(.center)
                .keyboardType(.decimalPad)
                .frame(width: 44)
                .padding(.vertical, 4)
                .background(RetroTheme.cream)
                .overlay(
                    Rectangle()
                        .frame(height: 1)
                        .foregroundStyle(RetroTheme.borderLight),
                    alignment: .bottom
                )
        }
    }

    private func intensityPicker() -> some View {
        VStack(alignment: .center, spacing: 2) {
            Text("Effort")
                .font(RetroTheme.smallFont)
                .foregroundStyle(RetroTheme.warmGray)

            Menu {
                ForEach(Intensity.allCases) { level in
                    Button(level.rawValue) {
                        exercise.intensity = level
                    }
                }
            } label: {
                Text(exercise.intensity?.rawValue ?? "Set")
                    .font(RetroTheme.captionFont)
                    .foregroundStyle(RetroTheme.inkBlack)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(RetroTheme.cream)
                    .overlay(
                        Rectangle()
                            .frame(height: 1)
                            .foregroundStyle(RetroTheme.borderLight),
                        alignment: .bottom
                    )
            }
        }
    }
}
