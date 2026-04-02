import SwiftUI

struct AddExerciseSheet: View {
    let section: ExerciseSection
    let onAdd: (String, WorkoutMode) -> Void

    @Environment(\.dismiss) private var dismiss
    @State private var exerciseName = ""
    @State private var selectedMode: WorkoutMode
    @FocusState private var nameFieldFocused: Bool

    init(section: ExerciseSection, defaultMode: WorkoutMode, onAdd: @escaping (String, WorkoutMode) -> Void) {
        self.section = section
        self.onAdd = onAdd
        _selectedMode = State(initialValue: defaultMode)
    }

    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("EXERCISE TYPE")
                        .font(RetroTheme.smallFont.weight(.bold))
                        .foregroundStyle(RetroTheme.warmGray)
                        .tracking(1)

                    RetroSegmentedPicker(
                        title: "Exercise type",
                        selection: $selectedMode
                    ) { mode in
                        RetroTheme.modeColor(mode)
                    } label: { mode in
                        mode.pickerLabel
                    }
                }

                VStack(alignment: .leading, spacing: 8) {
                    Text("EXERCISE NAME")
                        .font(RetroTheme.smallFont.weight(.bold))
                        .foregroundStyle(RetroTheme.warmGray)
                        .tracking(1)

                    TextField("e.g. Bench Press", text: $exerciseName)
                        .font(RetroTheme.bodyFont)
                        .foregroundStyle(RetroTheme.inkBlack)
                        .padding(14)
                        .background(
                            RoundedRectangle(cornerRadius: 14, style: .continuous)
                                .fill(RetroTheme.insetCream)
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 14, style: .continuous)
                                .strokeBorder(RetroTheme.borderLight, lineWidth: 1)
                        )
                        .focused($nameFieldFocused)
                        .submitLabel(.done)
                        .onSubmit { addExercise() }
                }

                Button {
                    addExercise()
                } label: {
                    Label("Add to \(section.label)", systemImage: "plus")
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 2)
                }
                .buttonStyle(RetroButtonStyle(color: RetroTheme.sectionColor(section), filled: true))
                .disabled(exerciseName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)

                VStack(alignment: .leading, spacing: 6) {
                    Text("TIP")
                        .font(RetroTheme.smallFont.weight(.bold))
                        .foregroundStyle(RetroTheme.warmGray)
                        .tracking(1)

                    Text(helperText)
                        .font(RetroTheme.captionFont)
                        .foregroundStyle(RetroTheme.warmGray)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .multilineTextAlignment(.leading)
                        .fixedSize(horizontal: false, vertical: true)
                        .layoutPriority(1)
                }

                Spacer()
            }
            .padding(20)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(RetroTheme.paperBase)
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
        .presentationBackground(RetroTheme.paperBase)
    }

    private func addExercise() {
        let name = exerciseName.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !name.isEmpty else { return }
        onAdd(name, selectedMode)
        dismiss()
    }

    private var helperText: String {
        switch section {
        case .warmup:
            return "Warmups work best when they are easy to start and often pair nicely with stretch or mobility work."
        case .main:
            return "The main block is the core of the day, so use clear names you can scan quickly later."
        case .cooldown:
            return "Cooldowns are a great place for a quick stretch, breathing drill, or mobility reset."
        }
    }
}
