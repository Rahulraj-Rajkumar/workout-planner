import SwiftUI
import SwiftData
#if canImport(UIKit)
import UIKit
#endif

struct DayDetailView: View {
    @Bindable var workoutDay: WorkoutDay
    @Environment(\.modelContext) private var modelContext
    @State private var showingAddSheetForSection: ExerciseSection?
    @State private var isArranging = false

    var body: some View {
        List {
            Section {
                headerView()
                    .listRowInsets(EdgeInsets(top: 14, leading: 14, bottom: 12, trailing: 14))
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.clear)
            }

            ForEach(ExerciseSection.allCases) { section in
                let exercises = workoutDay.exercises(for: section)

                Section {
                    if exercises.isEmpty {
                        EmptyStateView(section: section, suggestedMode: suggestedMode(for: section))
                            .listRowInsets(EdgeInsets(top: 8, leading: 14, bottom: 8, trailing: 14))
                            .listRowSeparator(.hidden)
                            .listRowBackground(Color.clear)
                    } else {
                        ForEach(exercises) { exercise in
                            ExerciseRowView(exercise: exercise, isArranging: isArranging)
                                .listRowInsets(EdgeInsets(top: 8, leading: 14, bottom: 8, trailing: 14))
                                .listRowSeparator(.hidden)
                                .listRowBackground(Color.clear)
                                .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                                    Button(role: .destructive) {
                                        deleteExercise(exercise)
                                    } label: {
                                        Label("Delete", systemImage: "trash")
                                    }
                                }
                        }
                        .onMove { source, destination in
                            moveExercises(in: section, from: source, to: destination)
                        }
                    }

                    addButton(for: section)
                        .listRowInsets(EdgeInsets(top: 4, leading: 14, bottom: 16, trailing: 14))
                        .listRowSeparator(.hidden)
                        .listRowBackground(Color.clear)
                } header: {
                    sectionHeader(section, count: exercises.count)
                }
            }
        }
        .listStyle(.plain)
        .scrollContentBackground(.hidden)
        .background(Color.clear)
        .environment(\.editMode, .constant(isArranging ? .active : .inactive))
        .scrollDismissesKeyboard(.interactively)
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Spacer()

                Button("Done") {
                    dismissKeyboard()
                }
                .font(RetroTheme.bodyFont.weight(.semibold))
                .foregroundStyle(RetroTheme.inkBlack)
            }
        }
        .sheet(item: $showingAddSheetForSection) { section in
            AddExerciseSheet(section: section, defaultMode: suggestedMode(for: section)) { name, mode in
                addExercise(name: name, mode: mode, to: section)
            }
        }
    }

    @ViewBuilder
    private func headerView() -> some View {
        VStack(alignment: .leading, spacing: 16) {
            VStack(alignment: .leading, spacing: 2) {
                Text(workoutDay.dayOfWeek.fullName)
                    .font(RetroTheme.titleFont)
                    .foregroundStyle(RetroTheme.inkBlack)
                    .lineLimit(1)
                    .minimumScaleFactor(0.85)

                let count = workoutDay.exerciseCount
                Text("\(count) exercise\(count == 1 ? "" : "s")")
                    .font(RetroTheme.captionFont)
                    .foregroundStyle(RetroTheme.warmGray)
            }

            modeSummaryStrip()

            VStack(alignment: .leading, spacing: 8) {
                Text("NEW EXERCISES")
                    .font(RetroTheme.smallFont.weight(.bold))
                    .foregroundStyle(RetroTheme.warmGray)
                    .tracking(1.1)

                HStack(spacing: 10) {
                    RetroSegmentedPicker(
                        title: "Default mode for new exercises",
                        selection: $workoutDay.defaultMode
                    ) { mode in
                        RetroTheme.modeColor(mode)
                    } label: { mode in
                        mode.pickerLabel
                    }

                    Button(isArranging ? "Done" : "Arrange") {
                        withAnimation(.easeInOut(duration: 0.18)) {
                            isArranging.toggle()
                        }
                    }
                    .buttonStyle(RetroSmallButtonStyle(color: RetroTheme.borderBrown))
                    .accessibilityLabel(isArranging ? "Finish arranging exercises" : "Arrange exercises")
                }
            }
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 18, style: .continuous)
                .fill(RetroTheme.chromeGradient)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 18, style: .continuous)
                .strokeBorder(RetroTheme.borderLight, lineWidth: 1)
        )
        .shadow(color: RetroTheme.shadowBrown.opacity(0.14), radius: 10, x: 0, y: 6)
    }

    @ViewBuilder
    private func modeSummaryStrip() -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("SESSION MIX")
                .font(RetroTheme.smallFont.weight(.bold))
                .foregroundStyle(RetroTheme.warmGray)
                .tracking(1.1)

            HStack(spacing: 0) {
                ForEach(Array(WorkoutMode.allCases.enumerated()), id: \.element.rawValue) { index, mode in
                    modeSummaryCell(for: mode)

                    if index < WorkoutMode.allCases.count - 1 {
                        Rectangle()
                            .fill(RetroTheme.borderLight.opacity(0.8))
                            .frame(width: 1)
                            .padding(.vertical, 8)
                    }
                }
            }
            .background(
                RoundedRectangle(cornerRadius: 14, style: .continuous)
                    .fill(RetroTheme.insetCream)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 14, style: .continuous)
                    .strokeBorder(RetroTheme.borderLight, lineWidth: 1)
            )
        }
    }

    @ViewBuilder
    private func modeSummaryCell(for mode: WorkoutMode) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack(spacing: 6) {
                Circle()
                    .fill(RetroTheme.modeColor(mode))
                    .frame(width: 8, height: 8)

                Text(mode.pickerLabel.uppercased())
                    .font(RetroTheme.smallFont.weight(.bold))
                    .foregroundStyle(RetroTheme.inkBlack)
                    .tracking(0.8)
                    .lineLimit(1)
                    .minimumScaleFactor(0.8)
            }

            Text("\(count(for: mode))")
                .font(.system(.title3, design: .monospaced).weight(.bold))
                .foregroundStyle(RetroTheme.inkBlack)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 12)
        .padding(.vertical, 10)
        .accessibilityElement(children: .ignore)
        .accessibilityLabel(mode.rawValue)
        .accessibilityValue("\(count(for: mode)) exercises")
    }

    @ViewBuilder
    private func sectionHeader(_ section: ExerciseSection, count: Int) -> some View {
        HStack(spacing: 8) {
            Capsule()
                .fill(RetroTheme.sectionColor(section))
                .frame(width: 8, height: 22)

            Image(systemName: section.systemIcon)
                .font(.system(size: 14, weight: .semibold))
                .foregroundStyle(RetroTheme.sectionColor(section))

            Text(section.label.uppercased())
                .font(RetroTheme.captionFont.weight(.bold))
                .foregroundStyle(RetroTheme.inkBlack)
                .tracking(1.8)

            Spacer()

            Text("\(count)")
                .font(RetroTheme.smallFont.weight(.bold))
                .foregroundStyle(RetroTheme.warmGray)
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(
                    Capsule()
                        .fill(RetroTheme.insetCream)
                )
                .overlay(
                    Capsule()
                        .strokeBorder(RetroTheme.borderLight, lineWidth: 1)
                )
        }
        .padding(.horizontal, 16)
        .padding(.top, 10)
        .padding(.bottom, 2)
    }

    @ViewBuilder
    private func addButton(for section: ExerciseSection) -> some View {
        Button {
            showingAddSheetForSection = section
        } label: {
            HStack(spacing: 8) {
                Image(systemName: "plus")
                    .font(.system(size: 12, weight: .bold))
                Text("Add \(section == .main ? "Exercise" : "Item")")
                    .font(RetroTheme.bodyFont.weight(.semibold))
            }
            .frame(maxWidth: .infinity)
        }
        .buttonStyle(RetroButtonStyle(color: RetroTheme.sectionColor(section), filled: false))
    }

    private func addExercise(name: String, mode: WorkoutMode, to section: ExerciseSection) {
        let existingCount = workoutDay.exercises(for: section).count
        let exercise = Exercise(
            name: name,
            section: section,
            mode: mode,
            sortOrder: existingCount
        )

        switch mode {
        case .strength:
            exercise.sets = 3
            exercise.reps = 10
            exercise.weight = 0
        case .cardio:
            exercise.durationMinutes = 30
            exercise.distanceKm = 0
            exercise.intensity = .moderate
        case .mobility:
            exercise.durationMinutes = 10
        }

        exercise.day = workoutDay
        modelContext.insert(exercise)
        try? modelContext.save()
    }

    private func deleteExercise(_ exercise: Exercise) {
        let section = exercise.section
        modelContext.delete(exercise)

        let remaining = workoutDay.exercises
            .filter { $0 !== exercise && $0.section == section }
            .sorted { $0.sortOrder < $1.sortOrder }

        for (index, ex) in remaining.enumerated() {
            ex.sortOrder = index
        }

        try? modelContext.save()
    }

    private func moveExercises(in section: ExerciseSection, from source: IndexSet, to destination: Int) {
        var exercises = workoutDay.exercises(for: section)
        exercises.move(fromOffsets: source, toOffset: destination)
        for (index, exercise) in exercises.enumerated() {
            exercise.sortOrder = index
        }
        try? modelContext.save()
    }

    private func suggestedMode(for section: ExerciseSection) -> WorkoutMode {
        switch section {
        case .warmup, .cooldown:
            return .mobility
        case .main:
            return workoutDay.defaultMode
        }
    }

    private func count(for mode: WorkoutMode) -> Int {
        workoutDay.exercises.filter { $0.mode == mode }.count
    }

    private func dismissKeyboard() {
        #if canImport(UIKit)
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        #endif
    }
}
