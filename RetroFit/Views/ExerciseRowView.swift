import SwiftUI

struct ExerciseRowView: View {
    @Bindable var exercise: Exercise
    let mode: WorkoutMode
    let onDelete: () -> Void

    @State private var isEditing = false

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(systemName: "line.3.horizontal")
                    .font(.system(size: 12))
                    .foregroundStyle(RetroTheme.lightGray)

                if isEditing {
                    TextField("Exercise name", text: $exercise.name)
                        .font(RetroTheme.headingFont)
                        .foregroundStyle(RetroTheme.inkBlack)
                        .textFieldStyle(.plain)
                        .onSubmit { isEditing = false }
                } else {
                    Text(exercise.name)
                        .font(RetroTheme.headingFont)
                        .foregroundStyle(RetroTheme.inkBlack)
                        .onTapGesture { isEditing = true }
                }

                Spacer()

                Button(role: .destructive) {
                    onDelete()
                } label: {
                    Image(systemName: "xmark")
                        .font(.system(size: 11, weight: .bold, design: .monospaced))
                        .foregroundStyle(RetroTheme.warmGray)
                        .frame(width: 24, height: 24)
                        .background(RetroTheme.cream)
                        .clipShape(RoundedRectangle(cornerRadius: 2))
                        .overlay(
                            RoundedRectangle(cornerRadius: 2)
                                .strokeBorder(RetroTheme.borderLight, lineWidth: 1)
                        )
                }
                .buttonStyle(.plain)
            }

            switch mode {
            case .strength:
                StrengthExerciseForm(exercise: exercise)
            case .cardio:
                CardioExerciseForm(exercise: exercise)
            }
        }
        .padding(RetroTheme.cardPadding)
        .background(RetroTheme.cream)
        .clipShape(RoundedRectangle(cornerRadius: RetroTheme.cornerRadius))
        .overlay(
            RoundedRectangle(cornerRadius: RetroTheme.cornerRadius)
                .strokeBorder(RetroTheme.borderLight, lineWidth: RetroTheme.thinBorder)
        )
    }
}
