import SwiftUI

struct RetroButtonStyle: ButtonStyle {
    var color: Color = RetroTheme.borderBrown
    var filled: Bool = false

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(RetroTheme.bodyFont)
            .foregroundStyle(filled ? RetroTheme.paperBase : color)
            .padding(.horizontal, 14)
            .padding(.vertical, 10)
            .background(
                RoundedRectangle(cornerRadius: RetroTheme.cornerRadius, style: .continuous)
                    .fill(
                        filled
                            ? AnyShapeStyle(
                                LinearGradient(
                                    colors: [color.opacity(0.96), color.opacity(0.80)],
                                    startPoint: .top,
                                    endPoint: .bottom
                                )
                            )
                            : AnyShapeStyle(RetroTheme.cardGradient)
                    )
            )
            .overlay(
                RoundedRectangle(cornerRadius: RetroTheme.cornerRadius, style: .continuous)
                    .strokeBorder(color, lineWidth: RetroTheme.borderWidth)
            )
            .offset(y: configuration.isPressed ? 1 : 0)
            .shadow(
                color: color.opacity(filled ? 0.24 : 0.12),
                radius: configuration.isPressed ? 3 : 9,
                x: 0,
                y: configuration.isPressed ? 2 : 6
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
            .padding(.vertical, 7)
            .background(
                RoundedRectangle(cornerRadius: RetroTheme.cornerRadius, style: .continuous)
                    .fill(RetroTheme.cardGradient)
            )
            .overlay(
                RoundedRectangle(cornerRadius: RetroTheme.cornerRadius, style: .continuous)
                    .strokeBorder(color.opacity(0.5), lineWidth: RetroTheme.thinBorder)
            )
            .shadow(
                color: RetroTheme.shadowBrown.opacity(configuration.isPressed ? 0.04 : 0.10),
                radius: 5,
                x: 0,
                y: 3
            )
            .opacity(configuration.isPressed ? 0.8 : 1.0)
    }
}
