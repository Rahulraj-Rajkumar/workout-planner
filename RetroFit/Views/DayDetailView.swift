import SwiftUI
import SwiftData

struct DayDetailView: View {
    @Bindable var workoutDay: WorkoutDay
    @Environment(\.modelContext) private var modelContext

    var body: some View {
        ScrollView {
            VStack(spacing: RetroTheme.sectionSpacing) {
                // Day header with mode toggle
                headerView()

                // Three workout sections
                ForEach(ExerciseSection.allCases) { section in
                    let exercises = workoutDay.exercises(for: section)
                    SectionView(
                        section: section,
                        mode: workoutDay.mode,
                        exercises: exercises,
                        onAdd: { name in addExercise(name: name, to: section) },
                        onDelete: { exercise in deleteExercise(exercise) },
                        onMove: { source, destination in
                            moveExercises(in: section, from: source, to: destination)
                        }
                    )
                }
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 32)
        }
        .scrollDismissesKeyboard(.interactively)
    }

    @ViewBuilder
    private func headerView() -> some View {
        VStack(spacing: 12) {
            HStack {
                VStack(alignment: .leading, spacing: 2) {
                    Text(workoutDay.dayOfWeek.fullName)
                        .font(RetroTheme.titleFont)
                        .foregroundStyle(RetroTheme.inkBlack)

                    let count = workoutDay.exercises.count
                    Text("\(count) exercise\(count == 1 ? "" : "s")")
                        .font(RetroTheme.captionFont)
                        .foregroundStyle(RetroTheme.warmGray)
                }

                Spacer()

                // Mode indicator icon
                Image(systemName: workoutDay.mode == .strength
                    ? "dumbbell.fill"
                    : "figure.run")
                    .font(.system(size: 22))
                    .foregroundStyle(RetroTheme.modeColor(workoutDay.mode))
            }

            RetroSegmentedPicker(
                title: "Mode",
                selection: $workoutDay.mode
            ) { mode in
                RetroTheme.modeColor(mode)
            }
        }
        .padding(RetroTheme.cardPadding)
    }

    private func addExercise(name: String, to section: ExerciseSection) {
        let existingCount = workoutDay.exercises(for: section).count
        let exercise = Exercise(
            name: name,
            section: section,
            sortOrder: existingCount
        )

        // Set defaults based on mode
        switch workoutDay.mode {
        case .strength:
            exercise.sets = 3
            exercise.reps = 10
            exercise.weight = 0
        case .cardio:
            exercise.durationMinutes = 30
            exercise.distanceKm = 0
            exercise.intensity = .moderate
        }

        exercise.day = workoutDay
        modelContext.insert(exercise)
    }

    private func deleteExercise(_ exercise: Exercise) {
        let section = exercise.section
        modelContext.delete(exercise)

        // Re-index remaining exercises in section
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            let remaining = workoutDay.exercises(for: section)
            for (index, ex) in remaining.enumerated() {
                ex.sortOrder = index
            }
        }
    }

    private func moveExercises(in section: ExerciseSection, from source: IndexSet, to destination: Int) {
        var exercises = workoutDay.exercises(for: section)
        exercises.move(fromOffsets: source, toOffset: destination)
        for (index, exercise) in exercises.enumerated() {
            exercise.sortOrder = index
        }
    }
}
