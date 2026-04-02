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
        .background(RetroTheme.parchment)
        .clipShape(RoundedRectangle(cornerRadius: RetroTheme.cornerRadius))
        .overlay(
            RoundedRectangle(cornerRadius: RetroTheme.cornerRadius)
                .strokeBorder(RetroTheme.borderLight, lineWidth: RetroTheme.thinBorder)
        )
        .shadow(color: RetroTheme.borderBrown.opacity(0.15), radius: 0, x: 1, y: 2)
    }
}

extension View {
    func retroCard(accent: Color? = nil) -> some View {
        modifier(RetroCard(accentColor: accent))
    }
}
