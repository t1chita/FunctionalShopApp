//
//  FShopTextStyle.swift
//  FunctionalShopApp
//
//  Created by Temur Chitashvili on 14.04.25.
//

import SwiftUI

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
        case .header: return .primaryButton.opacity(0.85)
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

struct FShopText_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            VStack(alignment: .leading, spacing: 12) {
                FShopText(text: "Big Title", style: .title)
                FShopText(text: "A nice subtitle", style: .subtitle)
                FShopText(text: "Section Header", style: .header)
                FShopText(text: "Regular body content goes here. It can be multiline and will stay consistent.", style: .body)
                FShopText(text: "Footnotes and extra hints", style: .caption)
            }
            .padding()
            .background(Color.background)
            
        }
    }
}
enum FShopCardTextStyle {
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
        case .title: return .primaryText1
        case .subtitle: return .secondary
        case .header: return .primaryButton.opacity(0.85)
        case .body: return .teritaryTextColor1
        case .caption: return .teritaryTextColor1.opacity(0.6)
        }
    }
}

struct FShopCardText: View {
    let text: String
    let style: FShopCardTextStyle
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
