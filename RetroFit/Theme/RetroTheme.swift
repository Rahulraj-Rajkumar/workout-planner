import SwiftUI
#if canImport(UIKit)
import UIKit
#endif

enum RetroTheme {
    // MARK: - Surfaces
    static let paperBase = Color(red: 0.95, green: 0.93, blue: 0.88)
    static let cream = paperBase
    static let parchment = Color(red: 0.91, green: 0.88, blue: 0.82)
    static let darkParchment = Color(red: 0.83, green: 0.80, blue: 0.74)
    static let insetCream = Color(red: 0.98, green: 0.97, blue: 0.94)
    static let chromeTop = Color(red: 0.90, green: 0.88, blue: 0.84)
    static let chromeBottom = Color(red: 0.82, green: 0.79, blue: 0.74)

    // MARK: - Text
    static let inkBlack = Color(red: 0.16, green: 0.14, blue: 0.13)
    static let warmGray = Color(red: 0.49, green: 0.46, blue: 0.42)
    static let lightGray = Color(red: 0.73, green: 0.69, blue: 0.64)

    // MARK: - Borders / Shadow
    static let borderBrown = Color(red: 0.43, green: 0.38, blue: 0.33)
    static let borderLight = Color(red: 0.73, green: 0.69, blue: 0.63)
    static let shadowBrown = Color(red: 0.28, green: 0.23, blue: 0.19)

    // MARK: - Apple Rainbow Accents
    static let retroGreen = Color(red: 0.42, green: 0.60, blue: 0.35)
    static let retroYellow = Color(red: 0.85, green: 0.75, blue: 0.35)
    static let retroOrange = Color(red: 0.82, green: 0.52, blue: 0.28)
    static let retroRed = Color(red: 0.75, green: 0.30, blue: 0.28)
    static let retroPurple = Color(red: 0.55, green: 0.35, blue: 0.58)
    static let retroBlue = Color(red: 0.30, green: 0.48, blue: 0.65)

    static let rainbowStripeColors: [Color] = [
        retroGreen,
        retroYellow,
        retroOrange,
        retroRed,
        retroPurple,
        retroBlue
    ]

    static func sectionColor(_ section: ExerciseSection) -> Color {
        switch section {
        case .warmup: return retroOrange
        case .main: return retroGreen
        case .cooldown: return retroBlue
        }
    }

    static func modeColor(_ mode: WorkoutMode) -> Color {
        switch mode {
        case .strength: return retroGreen
        case .cardio: return retroBlue
        case .mobility: return retroPurple
        }
    }

    static let chromeGradient = LinearGradient(
        colors: [chromeTop, chromeBottom],
        startPoint: .top,
        endPoint: .bottom
    )

    static let cardGradient = LinearGradient(
        colors: [paperBase, parchment],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )

    static func selectedDayGradient(_ accent: Color) -> LinearGradient {
        LinearGradient(
            colors: [accent.opacity(0.96), borderBrown.opacity(0.96)],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }

    static let titleFont: Font = .system(.title2, design: .monospaced).weight(.bold)
    static let headingFont: Font = .system(.headline, design: .monospaced).weight(.semibold)
    static let bodyFont: Font = .system(.body, design: .monospaced)
    static let captionFont: Font = .system(.caption, design: .monospaced)
    static let smallFont: Font = .system(.caption2, design: .monospaced)

    static let borderWidth: CGFloat = 2
    static let thinBorder: CGFloat = 1
    static let cornerRadius: CGFloat = 12
    static let cardPadding: CGFloat = 12
    static let sectionSpacing: CGFloat = 20
    static let itemSpacing: CGFloat = 8
    static let appHeaderDayStampWidth: CGFloat = 114
}

struct RetroBackground: View {
    var body: some View {
        ZStack {
            LinearGradient(
                colors: [RetroTheme.paperBase, RetroTheme.parchment, RetroTheme.darkParchment.opacity(0.92)],
                startPoint: .top,
                endPoint: .bottom
            )

            RadialGradient(
                colors: [Color.white.opacity(0.35), Color.clear],
                center: .top,
                startRadius: 20,
                endRadius: 420
            )

            GeometryReader { geometry in
                let lineCount = max(Int(geometry.size.height / 18), 1)

                VStack(spacing: 17) {
                    ForEach(0..<lineCount, id: \.self) { _ in
                        Rectangle()
                            .fill(Color.white.opacity(0.08))
                            .frame(height: 1)
                    }
                }
                .padding(.top, 6)
            }
        }
    }
}

private struct RetroKeyboardDoneModifier: ViewModifier {
    func body(content: Content) -> some View {
        content.toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Spacer()

                Button("Done") {
                    dismissKeyboard()
                }
                .font(RetroTheme.captionFont.weight(.semibold))
                .foregroundStyle(RetroTheme.inkBlack)
            }
        }
    }

    private func dismissKeyboard() {
        #if canImport(UIKit)
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        #endif
    }
}

extension View {
    func retroKeyboardDoneToolbar() -> some View {
        modifier(RetroKeyboardDoneModifier())
    }
}
