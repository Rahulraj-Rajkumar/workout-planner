import SwiftUI

struct RetroToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        Button {
            configuration.isOn.toggle()
        } label: {
            HStack(spacing: 8) {
                ZStack {
                    RoundedRectangle(cornerRadius: 2)
                        .strokeBorder(RetroTheme.borderBrown, lineWidth: RetroTheme.borderWidth)
                        .frame(width: 18, height: 18)
                        .background(
                            configuration.isOn ? RetroTheme.retroGreen.opacity(0.2) : Color.clear,
                            in: RoundedRectangle(cornerRadius: 2)
                        )

                    if configuration.isOn {
                        Image(systemName: "checkmark")
                            .font(.system(size: 11, weight: .bold, design: .monospaced))
                            .foregroundStyle(RetroTheme.inkBlack)
                    }
                }

                configuration.label
                    .font(RetroTheme.bodyFont)
                    .foregroundStyle(RetroTheme.inkBlack)
            }
        }
        .buttonStyle(.plain)
    }
}
