import SwiftUI

struct StrengthExerciseForm: View {
    @Bindable var exercise: Exercise

    var body: some View {
        HStack(spacing: 12) {
            fieldGroup("Sets", value: Binding(
                get: { exercise.sets ?? 0 },
                set: { exercise.sets = $0 }
            ))

            Text("\u{00D7}")
                .font(RetroTheme.bodyFont)
                .foregroundStyle(RetroTheme.warmGray)

            fieldGroup("Reps", value: Binding(
                get: { exercise.reps ?? 0 },
                set: { exercise.reps = $0 }
            ))

            Text("@")
                .font(RetroTheme.bodyFont)
                .foregroundStyle(RetroTheme.warmGray)

            weightField()
        }
    }

    private func fieldGroup(_ label: String, value: Binding<Int>) -> some View {
        VStack(alignment: .center, spacing: 2) {
            Text(label)
                .font(RetroTheme.smallFont)
                .foregroundStyle(RetroTheme.warmGray)

            TextField("0", value: value, format: .number)
                .font(RetroTheme.bodyFont)
                .foregroundStyle(RetroTheme.inkBlack)
                .multilineTextAlignment(.center)
                .keyboardType(.numberPad)
                .frame(width: 44)
                .padding(.vertical, 4)
                .background(
                    RetroTheme.cream
                )
                .overlay(
                    Rectangle()
                        .frame(height: 1)
                        .foregroundStyle(RetroTheme.borderLight),
                    alignment: .bottom
                )
        }
    }

    private func weightField() -> some View {
        VStack(alignment: .center, spacing: 2) {
            Text("lbs")
                .font(RetroTheme.smallFont)
                .foregroundStyle(RetroTheme.warmGray)

            TextField("0", value: Binding(
                get: { exercise.weight ?? 0 },
                set: { exercise.weight = $0 }
            ), format: .number)
                .font(RetroTheme.bodyFont)
                .foregroundStyle(RetroTheme.inkBlack)
                .multilineTextAlignment(.center)
                .keyboardType(.decimalPad)
                .frame(width: 52)
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
