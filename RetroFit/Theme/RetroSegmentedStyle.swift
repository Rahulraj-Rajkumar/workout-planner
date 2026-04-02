import SwiftUI

struct RetroSegmentedPicker<T: Hashable & CaseIterable & RawRepresentable>: View where T.AllCases: RandomAccessCollection, T.RawValue == String {
    let title: String
    @Binding var selection: T
    var accentColor: (T) -> Color = { _ in RetroTheme.retroGreen }
    var label: (T) -> String = { $0.rawValue }

    var body: some View {
        HStack(spacing: 0) {
            ForEach(Array(T.allCases), id: \.rawValue) { option in
                let isSelected = selection == option
                Button {
                    withAnimation(.easeInOut(duration: 0.15)) {
                        selection = option
                    }
                } label: {
                    Text(label(option))
                        .font(RetroTheme.captionFont)
                        .fontWeight(isSelected ? .bold : .regular)
                        .foregroundStyle(isSelected ? RetroTheme.paperBase : RetroTheme.inkBlack)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 9)
                        .background(
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .fill(
                                    isSelected
                                        ? AnyShapeStyle(RetroTheme.selectedDayGradient(accentColor(option)))
                                        : AnyShapeStyle(Color.clear)
                                )
                        )
                }
                .buttonStyle(.plain)
            }
        }
        .padding(3)
        .background(
            RoundedRectangle(cornerRadius: RetroTheme.cornerRadius, style: .continuous)
                .fill(RetroTheme.insetCream)
        )
        .overlay(
            RoundedRectangle(cornerRadius: RetroTheme.cornerRadius, style: .continuous)
                .strokeBorder(RetroTheme.borderBrown, lineWidth: RetroTheme.borderWidth)
        )
        .accessibilityLabel(title)
    }
}
