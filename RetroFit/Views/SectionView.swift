import SwiftUI
import SwiftData

struct SectionView: View {
    let section: ExerciseSection
    let mode: WorkoutMode
    let exercises: [Exercise]
    let onAdd: (String) -> Void
    let onDelete: (Exercise) -> Void
    let onMove: (IndexSet, Int) -> Void

    @State private var showingAddSheet = false

    private var accentColor: Color {
        RetroTheme.sectionColor(section)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: RetroTheme.itemSpacing) {
            // Section header
            HStack(spacing: 8) {
                Rectangle()
                    .fill(accentColor)
                    .frame(width: 3, height: 20)

                Image(systemName: section.systemIcon)
                    .font(.system(size: 14, design: .monospaced))
                    .foregroundStyle(accentColor)

                Text(section.label.uppercased())
                    .font(RetroTheme.captionFont)
                    .fontWeight(.bold)
                    .foregroundStyle(RetroTheme.inkBlack)
                    .tracking(2)

                Spacer()

                Text("\(exercises.count)")
                    .font(RetroTheme.smallFont)
                    .foregroundStyle(RetroTheme.warmGray)
                    .padding(.horizontal, 6)
                    .padding(.vertical, 2)
                    .background(RetroTheme.cream)
                    .clipShape(RoundedRectangle(cornerRadius: 2))
                    .overlay(
                        RoundedRectangle(cornerRadius: 2)
                            .strokeBorder(RetroTheme.borderLight, lineWidth: 1)
                    )
            }
            .padding(.horizontal, 4)

            // Exercise list
            if exercises.isEmpty {
                EmptyStateView(section: section)
            } else {
                ForEach(exercises) { exercise in
                    ExerciseRowView(
                        exercise: exercise,
                        mode: mode,
                        onDelete: { onDelete(exercise) }
                    )
                }
            }

            // Add button
            Button {
                showingAddSheet = true
            } label: {
                HStack(spacing: 6) {
                    Image(systemName: "plus")
                        .font(.system(size: 12, weight: .bold, design: .monospaced))
                    Text("Add Exercise")
                }
            }
            .buttonStyle(RetroSmallButtonStyle(color: accentColor))
            .frame(maxWidth: .infinity, alignment: .center)
            .padding(.top, 4)
        }
        .padding(RetroTheme.cardPadding)
        .background(RetroTheme.parchment)
        .clipShape(RoundedRectangle(cornerRadius: RetroTheme.cornerRadius))
        .overlay(
            RoundedRectangle(cornerRadius: RetroTheme.cornerRadius)
                .strokeBorder(RetroTheme.borderLight, lineWidth: RetroTheme.thinBorder)
        )
        .shadow(color: RetroTheme.borderBrown.opacity(0.1), radius: 0, x: 1, y: 2)
        .sheet(isPresented: $showingAddSheet) {
            AddExerciseSheet(section: section, onAdd: onAdd)
        }
    }
}
