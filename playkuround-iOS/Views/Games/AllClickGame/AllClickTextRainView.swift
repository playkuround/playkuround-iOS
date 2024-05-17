//
//  AllClickTextRainView.swift
//  playkuround-iOS
//
//  Created by Seoyeon Choi on 4/27/24.
//

import SwiftUI

struct AllClickTextRainView: View {
    let subject: String
    
    var body: some View {
        ZStack {
            Color.black
            
            Text(subject)
                .font(.neo15)
                .kerning(-0.41)
                .foregroundStyle(.kuText)
                .textRainStroke()
        }
    }
}

#Preview {
    AllClickTextRainView(subject: "비판적사고와토론")
}

extension View {
    func textRainStroke() -> some View {
        modifier(StrokeModifier())
    }
}

struct StrokeModifier: ViewModifier {
    private let id = UUID()
    var strokeSize: CGFloat = 1.2
    var strokeColor: Color = .white
    
    func body(content: Content) -> some View {
        content
            .padding(strokeSize*2)
            .background(Rectangle().foregroundStyle(strokeColor))
            .mask({
                outline(context: content)
            })
    }
    
    func outline(context: Content) -> some View {
        Canvas { context, size in
            context.addFilter(.alphaThreshold(min: 0.01))
            context.drawLayer { layer in
                if let text = context.resolveSymbol(id: id) {
                    layer.draw(text, at: .init(x: size.width/2, y: size.height/2))
                }
            }
        }symbols: {
            context.tag(id)
                .blur(radius: strokeSize)
        }
    }
}
