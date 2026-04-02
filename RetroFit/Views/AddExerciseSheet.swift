import SwiftUI

struct AddExerciseSheet: View {
    let section: ExerciseSection
    let onAdd: (String) -> Void

    @Environment(\.dismiss) private var dismiss
    @State private var exerciseName = ""
    @FocusState private var nameFieldFocused: Bool

    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("EXERCISE NAME")
                        .font(RetroTheme.smallFont)
                        .foregroundStyle(RetroTheme.warmGray)
                        .tracking(1)

                    TextField("e.g. Bench Press", text: $exerciseName)
                        .font(RetroTheme.bodyFont)
                        .foregroundStyle(RetroTheme.inkBlack)
                        .padding(12)
                        .background(RetroTheme.cream)
                        .clipShape(RoundedRectangle(cornerRadius: RetroTheme.cornerRadius))
                        .overlay(
                            RoundedRectangle(cornerRadius: RetroTheme.cornerRadius)
                                .strokeBorder(RetroTheme.borderBrown, lineWidth: RetroTheme.borderWidth)
                        )
                        .focused($nameFieldFocused)
                        .onSubmit { addExercise() }
                }

                Button {
                    addExercise()
                } label: {
                    Text("Add to \(section.label)")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(RetroButtonStyle(color: RetroTheme.sectionColor(section), filled: true))
                .disabled(exerciseName.trimmingCharacters(in: .whitespaces).isEmpty)

                Spacer()
            }
            .padding(20)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(RetroTheme.parchment)
            .navigationTitle("New Exercise")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                        .font(RetroTheme.bodyFont)
                        .foregroundStyle(RetroTheme.warmGray)
                }
            }
        }
        .onAppear { nameFieldFocused = true }
        .presentationDetents([.medium])
        .presentationDragIndicator(.visible)
    }

    private func addExercise() {
        let name = exerciseName.trimmingCharacters(in: .whitespaces)
        guard !name.isEmpty else { return }
        onAdd(name)
        dismiss()
    }
}
