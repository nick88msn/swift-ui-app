//
//  Cardify.swift
//  Memorize
//
//  Created by Nicola Mastrandrea on 08/06/21.
//

import SwiftUI

struct Cardify: ViewModifier{
    var isFacedUp: Bool
    
    func body(content: Content) -> some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
            if isFacedUp {
                shape.fill().foregroundColor(.blue)
                shape.strokeBorder(lineWidth: DrawingConstants.lineWidth).foregroundColor(.blue)
            } else {
                shape.fill().foregroundColor(/*@START_MENU_TOKEN@*/.orange/*@END_MENU_TOKEN@*/)
                shape.strokeBorder(lineWidth: 1.5).foregroundColor(.orange)
            }
            content
                .opacity(isFacedUp ? 1 : 0)
        }
        .padding()

    }
    
    private struct DrawingConstants {
        static let cornerRadius: CGFloat = 25.0
        static let lineWidth: CGFloat = 1.5
    }

}


extension View{
    func cardify(isFacedUp:Bool) -> some View{
        modifier(Cardify(isFacedUp: isFacedUp))
    }
}
