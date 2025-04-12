//
//  FShopButton.swift
//  FunctionalShopApp
//
//  Created by Temur Chitashvili on 13.04.25.
//

import SwiftUI
enum FShopButtonSize: CaseIterable {
    case large
    case small
    
    var verticalPadding: CGFloat {
        switch self {
        case .large: return 16
        case .small: return 8
        }
    }
    
    var fontSize: CGFloat {
        switch self {
        case .large: return 16
        case .small: return 12
        }
    }
    
    var cornerRadius: CGFloat {
        switch self {
        case .large: return 10
        case .small: return 6
        }
    }
    
    var borderWidth: CGFloat {
        switch self {
        case .large: return 4
        case .small: return 2
        }
    }
}

enum FShopButtonStyle: CaseIterable {
    case primary
    case primaryDisabled
    case secondary
    case secondaryDisabled
    
    var backgroundColor: Color {
        switch self {
        case .primary: return .primaryButton
        case .primaryDisabled: return .primaryButton.opacity(0.3)
        case .secondary, .secondaryDisabled: return .clear
        }
    }
    
    var foregroundColor: Color {
        switch self {
        case .primary, .secondary: return .primaryText
        case .primaryDisabled: return .primaryText.opacity(0.2)
        case .secondaryDisabled: return .primaryText.opacity(0.2)
        }
    }
    
    var borderColor: Color? {
        switch self {
        case .secondary: return .primaryButton
        case .secondaryDisabled: return .primaryButton.opacity(0.3)
        default: return nil
        }
    }
    
    var isDisabled: Bool {
        switch self {
        case .primaryDisabled, .secondaryDisabled: return true
        default: return false
        }
    }
}

struct FShopButton: View {
    let title: String
    let style: FShopButtonStyle
    let size: FShopButtonSize
    let action: () -> Void
    var width: CGFloat? = nil
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: size.fontSize, weight: .semibold))
                .foregroundColor(style.foregroundColor)
                .padding(.vertical, size.verticalPadding)
                .frame(maxWidth: width == nil ? .infinity : width)
                .background(style.backgroundColor)
                .overlay(
                    RoundedRectangle(cornerRadius: size.cornerRadius)
                        .stroke(style.borderColor ?? .clear, lineWidth: style.borderColor != nil ? size.borderWidth : 0)
                )
                .cornerRadius(size.cornerRadius)
        }
        .disabled(style.isDisabled)
    }
}

#Preview {
    ScrollView {
        VStack(alignment: .leading, spacing: 24) {
            
            // Small Buttons (Half Width)
            Text("Small Buttons (Half Width)")
                .font(.title2.bold())
            
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                ForEach(FShopButtonStyle.allCases, id: \.self) { style in
                    FShopButton(
                        title: "\(style)".capitalized,
                        style: style,
                        size: .small,
                        action: { print("\(style) tapped") },
                        width: UIScreen.main.bounds.width / 2 - 32
                    )
                }
            }
            
            // Large Buttons (Full Width)
            Text("Large Buttons (Full Width)")
                .font(.title2.bold())
            
            VStack(spacing: 16) {
                ForEach(FShopButtonStyle.allCases, id: \.self) { style in
                    FShopButton(
                        title: "\(style)".capitalized,
                        style: style,
                        size: .large,
                        action: { print("\(style) tapped") }
                    )
                }
            }
        }
        .padding()
    }
}

enum FShopTextStyle {
    case title
    case subtitle
    case body
    case caption
    case header
    
    var font: Font {
        switch self {
        case .title: return .system(size: 28, weight: .bold)
        case .subtitle: return .system(size: 22, weight: .semibold)
        case .header: return .system(size: 20, weight: .medium)
        case .body: return .system(size: 16, weight: .regular)
        case .caption: return .system(size: 12, weight: .light)
        }
    }
    
    var color: Color {
        switch self {
        case .title: return .primaryText
        case .subtitle: return .secondary
        case .header: return .blue
        case .body: return .teritaryText
        case .caption: return .teritaryText.opacity(0.6)
        }
    }
}

struct FShopText: View {
    let text: String
    let style: FShopTextStyle
    var alignment: TextAlignment = .leading
    var lineLimit: Int? = nil
    
    var body: some View {
        Text(text)
            .font(style.font)
            .foregroundColor(style.color)
            .multilineTextAlignment(alignment)
            .lineLimit(lineLimit)
    }
}

