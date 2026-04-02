import SwiftUI

enum RetroTheme {
    // MARK: - Background Colors
    static let cream = Color(red: 0.96, green: 0.94, blue: 0.88)
    static let parchment = Color(red: 0.92, green: 0.89, blue: 0.82)
    static let darkParchment = Color(red: 0.85, green: 0.82, blue: 0.75)

    // MARK: - Text Colors
    static let inkBlack = Color(red: 0.13, green: 0.13, blue: 0.13)
    static let warmGray = Color(red: 0.55, green: 0.52, blue: 0.48)
    static let lightGray = Color(red: 0.75, green: 0.72, blue: 0.68)

    // MARK: - Border
    static let borderBrown = Color(red: 0.45, green: 0.40, blue: 0.35)
    static let borderLight = Color(red: 0.70, green: 0.66, blue: 0.60)

    // MARK: - Apple Rainbow Accents (muted vintage)
    static let retroGreen = Color(red: 0.42, green: 0.60, blue: 0.35)
    static let retroYellow = Color(red: 0.85, green: 0.75, blue: 0.35)
    static let retroOrange = Color(red: 0.82, green: 0.52, blue: 0.28)
    static let retroRed = Color(red: 0.75, green: 0.30, blue: 0.28)
    static let retroPurple = Color(red: 0.55, green: 0.35, blue: 0.58)
    static let retroBlue = Color(red: 0.30, green: 0.48, blue: 0.65)

    // MARK: - Section Accents
    static func sectionColor(_ section: ExerciseSection) -> Color {
        switch section {
        case .warmup: return retroOrange
        case .main: return retroGreen
        case .cooldown: return retroBlue
        }
    }

    // MARK: - Mode Colors
    static func modeColor(_ mode: WorkoutMode) -> Color {
        switch mode {
        case .strength: return retroGreen
        case .cardio: return retroBlue
        }
    }

    // MARK: - Fonts
    static let titleFont: Font = .system(.title2, design: .monospaced).weight(.bold)
    static let headingFont: Font = .system(.headline, design: .monospaced).weight(.semibold)
    static let bodyFont: Font = .system(.body, design: .monospaced)
    static let captionFont: Font = .system(.caption, design: .monospaced)
    static let smallFont: Font = .system(.caption2, design: .monospaced)

    // MARK: - Layout
    static let borderWidth: CGFloat = 2
    static let thinBorder: CGFloat = 1
    static let cornerRadius: CGFloat = 4
    static let cardPadding: CGFloat = 12
    static let sectionSpacing: CGFloat = 20
    static let itemSpacing: CGFloat = 8
}
