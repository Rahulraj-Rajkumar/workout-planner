import SwiftUI

struct RetroCard: ViewModifier {
    var accentColor: Color? = nil

    func body(content: Content) -> some View {
        HStack(spacing: 0) {
            if let accent = accentColor {
                accent
                    .frame(width: 4)
            }
            content
                .padding(RetroTheme.cardPadding)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .background(
            RoundedRectangle(cornerRadius: RetroTheme.cornerRadius, style: .continuous)
                .fill(RetroTheme.cardGradient)
        )
        .overlay(
            RoundedRectangle(cornerRadius: RetroTheme.cornerRadius, style: .continuous)
                .strokeBorder(RetroTheme.borderLight, lineWidth: RetroTheme.thinBorder)
        )
        .shadow(color: RetroTheme.shadowBrown.opacity(0.12), radius: 10, x: 0, y: 6)
    }
}

extension View {
    func retroCard(accent: Color? = nil) -> some View {
        modifier(RetroCard(accentColor: accent))
    }
}
