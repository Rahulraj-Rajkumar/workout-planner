import SwiftUI

struct StrengthExerciseForm: View {
    @Bindable var exercise: Exercise

    var body: some View {
        HStack(spacing: 12) {
            fieldGroup("SETS", width: 68, value: Binding(
                get: { exercise.sets ?? 0 },
                set: { exercise.sets = $0 }
            ), accessibilityLabel: "Sets")

            fieldGroup("REPS", width: 68, value: Binding(
                get: { exercise.reps ?? 0 },
                set: { exercise.reps = $0 }
            ), accessibilityLabel: "Repetitions")

            weightField()
        }
    }

    private func fieldGroup(_ label: String, width: CGFloat, value: Binding<Int>, accessibilityLabel: String) -> some View {
        VStack(alignment: .center, spacing: 2) {
            Text(label)
                .font(RetroTheme.smallFont.weight(.bold))
                .foregroundStyle(RetroTheme.warmGray)
                .tracking(1)

            TextField("0", value: value, format: .number)
                .font(RetroTheme.bodyFont)
                .foregroundStyle(RetroTheme.inkBlack)
                .multilineTextAlignment(.center)
                .keyboardType(.numberPad)
                .frame(width: width)
                .padding(.vertical, 8)
                .background(RetroTheme.insetCream, in: RoundedRectangle(cornerRadius: 10, style: .continuous))
                .overlay(
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .strokeBorder(RetroTheme.borderLight, lineWidth: 1)
                )
                .accessibilityLabel(accessibilityLabel)
        }
    }

    private func weightField() -> some View {
        VStack(alignment: .center, spacing: 2) {
            Text("LBS")
                .font(RetroTheme.smallFont.weight(.bold))
                .foregroundStyle(RetroTheme.warmGray)
                .tracking(1)

            TextField("0", value: Binding(
                get: { exercise.weight ?? 0 },
                set: { exercise.weight = $0 }
            ), format: .number)
                .font(RetroTheme.bodyFont)
                .foregroundStyle(RetroTheme.inkBlack)
                .multilineTextAlignment(.center)
                .keyboardType(.decimalPad)
                .frame(width: 84)
                .padding(.vertical, 8)
                .background(RetroTheme.insetCream, in: RoundedRectangle(cornerRadius: 10, style: .continuous))
                .overlay(
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .strokeBorder(RetroTheme.borderLight, lineWidth: 1)
                )
                .accessibilityLabel("Weight in pounds")
        }
    }
}
