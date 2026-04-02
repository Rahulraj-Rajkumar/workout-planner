import SwiftUI

struct EmptyStateView: View {
    let section: ExerciseSection
    var suggestedMode: WorkoutMode? = nil

    var body: some View {
        VStack(spacing: 10) {
            Image(systemName: section.systemIcon)
                .font(.system(size: 24, weight: .regular, design: .rounded))
                .foregroundStyle(RetroTheme.lightGray)

            Text("No exercises yet")
                .font(RetroTheme.captionFont.weight(.semibold))
                .foregroundStyle(RetroTheme.warmGray)

            Text(suggestedMode.map { "Try a \($0.rawValue.lowercased()) \(section.label.lowercased()) first." } ?? "Tap Add to create one.")
                .font(RetroTheme.smallFont)
                .foregroundStyle(RetroTheme.lightGray)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 20)
        .padding(.horizontal, 14)
        .background(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .fill(RetroTheme.cardGradient)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .strokeBorder(RetroTheme.borderLight, lineWidth: 1)
        )
    }
}
