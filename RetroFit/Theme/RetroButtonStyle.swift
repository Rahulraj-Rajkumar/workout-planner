import SwiftUI

struct RetroButtonStyle: ButtonStyle {
    var color: Color = RetroTheme.borderBrown
    var filled: Bool = false

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(RetroTheme.bodyFont)
            .foregroundStyle(filled ? RetroTheme.cream : color)
            .padding(.horizontal, 14)
            .padding(.vertical, 8)
            .background(
                filled ? color : RetroTheme.parchment,
                in: RoundedRectangle(cornerRadius: RetroTheme.cornerRadius)
            )
            .overlay(
                RoundedRectangle(cornerRadius: RetroTheme.cornerRadius)
                    .strokeBorder(color, lineWidth: RetroTheme.borderWidth)
            )
            .offset(y: configuration.isPressed ? 1 : 0)
            .shadow(
                color: color.opacity(0.3),
                radius: 0,
                x: configuration.isPressed ? 0 : 1,
                y: configuration.isPressed ? 0 : 2
            )
    }
}

struct RetroSmallButtonStyle: ButtonStyle {
    var color: Color = RetroTheme.warmGray

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(RetroTheme.captionFont)
            .foregroundStyle(color)
            .padding(.horizontal, 10)
            .padding(.vertical, 5)
            .background(
                RetroTheme.cream,
                in: RoundedRectangle(cornerRadius: RetroTheme.cornerRadius)
            )
            .overlay(
                RoundedRectangle(cornerRadius: RetroTheme.cornerRadius)
                    .strokeBorder(color.opacity(0.5), lineWidth: RetroTheme.thinBorder)
            )
            .opacity(configuration.isPressed ? 0.7 : 1.0)
    }
}
