import SwiftUI

struct RetroSegmentedPicker<T: Hashable & CaseIterable & RawRepresentable>: View where T.AllCases: RandomAccessCollection, T.RawValue == String {
    let title: String
    @Binding var selection: T
    var accentColor: (T) -> Color = { _ in RetroTheme.retroGreen }

    var body: some View {
        HStack(spacing: 0) {
            ForEach(Array(T.allCases), id: \.rawValue) { option in
                let isSelected = selection == option
                Button {
                    withAnimation(.easeInOut(duration: 0.15)) {
                        selection = option
                    }
                } label: {
                    Text(option.rawValue)
                        .font(RetroTheme.captionFont)
                        .fontWeight(isSelected ? .bold : .regular)
                        .foregroundStyle(isSelected ? RetroTheme.cream : RetroTheme.inkBlack)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 8)
                        .background(isSelected ? accentColor(option) : Color.clear)
                }
                .buttonStyle(.plain)
            }
        }
        .background(RetroTheme.cream)
        .clipShape(RoundedRectangle(cornerRadius: RetroTheme.cornerRadius))
        .overlay(
            RoundedRectangle(cornerRadius: RetroTheme.cornerRadius)
                .strokeBorder(RetroTheme.borderBrown, lineWidth: RetroTheme.borderWidth)
        )
    }
}
