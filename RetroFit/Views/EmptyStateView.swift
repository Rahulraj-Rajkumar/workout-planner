import SwiftUI

struct EmptyStateView: View {
    let section: ExerciseSection

    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: section.systemIcon)
                .font(.system(size: 24, design: .monospaced))
                .foregroundStyle(RetroTheme.lightGray)

            Text("No exercises yet")
                .font(RetroTheme.captionFont)
                .foregroundStyle(RetroTheme.warmGray)

            Text("Tap + to add one")
                .font(RetroTheme.smallFont)
                .foregroundStyle(RetroTheme.lightGray)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 16)
    }
}
