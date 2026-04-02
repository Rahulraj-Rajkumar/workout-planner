import SwiftUI

struct CardioExerciseForm: View {
    @Bindable var exercise: Exercise

    var body: some View {
        HStack(spacing: 12) {
            durationField()
            distanceField()
            intensityPicker()
        }
    }

    private func durationField() -> some View {
        VStack(alignment: .center, spacing: 2) {
            Text("MIN")
                .font(RetroTheme.smallFont.weight(.bold))
                .foregroundStyle(RetroTheme.warmGray)
                .tracking(1)

            TextField("0", value: Binding(
                get: { exercise.durationMinutes ?? 0 },
                set: { exercise.durationMinutes = $0 }
            ), format: .number)
                .font(RetroTheme.bodyFont)
                .foregroundStyle(RetroTheme.inkBlack)
                .multilineTextAlignment(.center)
                .keyboardType(.decimalPad)
                .frame(width: 74)
                .padding(.vertical, 8)
                .background(RetroTheme.insetCream, in: RoundedRectangle(cornerRadius: 10, style: .continuous))
                .overlay(
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .strokeBorder(RetroTheme.borderLight, lineWidth: 1)
                )
                .accessibilityLabel("Duration in minutes")
        }
    }

    private func distanceField() -> some View {
        VStack(alignment: .center, spacing: 2) {
            Text("KM")
                .font(RetroTheme.smallFont.weight(.bold))
                .foregroundStyle(RetroTheme.warmGray)
                .tracking(1)

            TextField("0", value: Binding(
                get: { exercise.distanceKm ?? 0 },
                set: { exercise.distanceKm = $0 }
            ), format: .number)
                .font(RetroTheme.bodyFont)
                .foregroundStyle(RetroTheme.inkBlack)
                .multilineTextAlignment(.center)
                .keyboardType(.decimalPad)
                .frame(width: 74)
                .padding(.vertical, 8)
                .background(RetroTheme.insetCream, in: RoundedRectangle(cornerRadius: 10, style: .continuous))
                .overlay(
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .strokeBorder(RetroTheme.borderLight, lineWidth: 1)
                )
                .accessibilityLabel("Distance in kilometers")
        }
    }

    private func intensityPicker() -> some View {
        VStack(alignment: .center, spacing: 2) {
            Text("EFFORT")
                .font(RetroTheme.smallFont.weight(.bold))
                .foregroundStyle(RetroTheme.warmGray)
                .tracking(1)

            Menu {
                ForEach(Intensity.allCases) { level in
                    Button(level.rawValue) {
                        exercise.intensity = level
                    }
                }
            } label: {
                Text(exercise.intensity?.rawValue ?? "Set")
                    .font(RetroTheme.captionFont.weight(.semibold))
                    .foregroundStyle(RetroTheme.inkBlack)
                    .frame(minWidth: 84)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 8)
                    .background(RetroTheme.insetCream, in: RoundedRectangle(cornerRadius: 10, style: .continuous))
                    .overlay(
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .strokeBorder(RetroTheme.borderLight, lineWidth: 1)
                    )
            }
            .accessibilityLabel("Intensity")
        }
    }
}

struct MobilityExerciseForm: View {
    @Bindable var exercise: Exercise

    var body: some View {
        HStack(spacing: 12) {
            durationField()

            Text("Gentle stretch or mobility flow")
                .font(RetroTheme.captionFont)
                .foregroundStyle(RetroTheme.warmGray)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 12)
                .padding(.vertical, 10)
                .background(RetroTheme.insetCream, in: RoundedRectangle(cornerRadius: 10, style: .continuous))
                .overlay(
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .strokeBorder(RetroTheme.borderLight, lineWidth: 1)
                )
        }
    }

    private func durationField() -> some View {
        VStack(alignment: .center, spacing: 2) {
            Text("MIN")
                .font(RetroTheme.smallFont.weight(.bold))
                .foregroundStyle(RetroTheme.warmGray)
                .tracking(1)

            TextField("0", value: Binding(
                get: { exercise.durationMinutes ?? 0 },
                set: { exercise.durationMinutes = $0 }
            ), format: .number)
                .font(RetroTheme.bodyFont)
                .foregroundStyle(RetroTheme.inkBlack)
                .multilineTextAlignment(.center)
                .keyboardType(.decimalPad)
                .frame(width: 74)
                .padding(.vertical, 8)
                .background(RetroTheme.insetCream, in: RoundedRectangle(cornerRadius: 10, style: .continuous))
                .overlay(
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .strokeBorder(RetroTheme.borderLight, lineWidth: 1)
                )
                .accessibilityLabel("Mobility duration in minutes")
        }
    }
}
