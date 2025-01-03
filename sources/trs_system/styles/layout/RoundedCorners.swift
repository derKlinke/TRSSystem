import Foundation
import SwiftUI

// MARK: - RoundedTRSRectangle
public struct RoundedTRSRectangle: Shape {
    let size: TRSSizes

    public init(size: TRSSizes) {
        self.size = size
    }

    public func path(in rect: CGRect) -> Path {
        Path(roundedRect: rect, cornerRadius: size.value)
    }
}

// MARK: - RoundedClip
public struct RoundedClip: ViewModifier {
    let size: TRSSizes

    public init(size: TRSSizes) {
        self.size = size
    }

    public func body(content: Content) -> some View {
        content.clipShape(RoundedTRSRectangle(size: size))
    }
}

// MARK: - BorderClipModifier
struct BorderClipModifier: ViewModifier {
    @EnvironmentObject private var themeManager: ThemeManager

    let size: TRSSizes
    let color: ThemeElement

    func body(content: Content) -> some View {
        content
            .roundedClip(size)
            .overlay {
                RoundedTRSRectangle(size: size)
                    .stroke(themeManager.color(for: color).color,
                            lineWidth: size.value / 10)
            }
    }
}

extension View {
    public func roundedClip(_ size: TRSSizes = .medium) -> some View {
        self.modifier(RoundedClip(size: size))
    }

    public func borderClip(_ size: TRSSizes = .tiny, color: ThemeElement = .separator) -> some View {
        self.modifier(BorderClipModifier(size: size, color: color))
    }
}
