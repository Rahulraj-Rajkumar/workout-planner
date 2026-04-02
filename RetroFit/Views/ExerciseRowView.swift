import SwiftUI

struct ExerciseRowView: View {
    @Bindable var exercise: Exercise
    let isArranging: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(alignment: .top, spacing: 12) {
                VStack(alignment: .leading, spacing: 6) {
                    Text("EXERCISE")
                        .font(RetroTheme.smallFont.weight(.bold))
                        .foregroundStyle(RetroTheme.warmGray)
                        .tracking(1.1)

                    TextField("Exercise name", text: $exercise.name)
                        .font(RetroTheme.headingFont)
                        .foregroundStyle(RetroTheme.inkBlack)
                        .textFieldStyle(.plain)
                        .submitLabel(.done)
                        .onSubmit {
                            exercise.name = exercise.name.trimmingCharacters(in: .whitespacesAndNewlines)
                        }
                        .accessibilityLabel("Exercise name")
                }

                Spacer(minLength: 0)

                modePicker()
            }
            .padding(.bottom, 2)

            switch exercise.mode {
            case .strength:
                StrengthExerciseForm(exercise: exercise)
            case .cardio:
                CardioExerciseForm(exercise: exercise)
            case .mobility:
                MobilityExerciseForm(exercise: exercise)
            }
        }
        .padding(14)
        .background(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .fill(RetroTheme.cardGradient)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .strokeBorder(RetroTheme.borderLight.opacity(0.9), lineWidth: 1)
        )
        .opacity(isArranging ? 0.92 : 1)
    }

    @ViewBuilder
    private func modePicker() -> some View {
        Menu {
            ForEach(WorkoutMode.allCases, id: \.rawValue) { mode in
                Button {
                    apply(mode)
                } label: {
                    Label(mode.rawValue, systemImage: mode.systemIcon)
                }
            }
        } label: {
            HStack(spacing: 6) {
                Image(systemName: exercise.mode.systemIcon)
                    .font(.system(size: 12, weight: .bold))

                Text(exercise.mode.shortLabel)
                    .font(RetroTheme.smallFont.weight(.bold))
            }
            .foregroundStyle(RetroTheme.modeColor(exercise.mode))
            .padding(.horizontal, 10)
            .padding(.vertical, 7)
            .background(
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .fill(RetroTheme.insetCream)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .strokeBorder(RetroTheme.borderLight, lineWidth: 1)
            )
        }
        .buttonStyle(.plain)
        .accessibilityLabel("Exercise type")
        .accessibilityValue(exercise.mode.rawValue)
    }

    private func apply(_ mode: WorkoutMode) {
        exercise.mode = mode

        switch mode {
        case .strength:
            if exercise.sets == nil { exercise.sets = 3 }
            if exercise.reps == nil { exercise.reps = 10 }
            if exercise.weight == nil { exercise.weight = 0 }
        case .cardio:
            if exercise.durationMinutes == nil { exercise.durationMinutes = 20 }
            if exercise.distanceKm == nil { exercise.distanceKm = 0 }
            if exercise.intensity == nil { exercise.intensity = .moderate }
        case .mobility:
            if exercise.durationMinutes == nil { exercise.durationMinutes = 10 }
        }
    }
}
