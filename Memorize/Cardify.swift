//
//  Cardify.swift
//  Memorize
//
//  Created by Nicola Mastrandrea on 08/06/21.
//

import SwiftUI

struct Cardify: AnimatableModifier {
    init(isFaceUp: Bool){
        rotation = isFaceUp ? 0 : 180
    }
    
    // To handle cards' flipping animation we need to keep track of the rotation angle
    var animatableData: Double {
        get { rotation }
        set { rotation = newValue }
    }
    
    var rotation: Double

    
    func body(content: Content) -> some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
            if rotation < 90 {
                shape.fill().foregroundColor(.blue)
                shape.strokeBorder(lineWidth: DrawingConstants.lineWidth).foregroundColor(.blue)
            } else {
                shape.fill().foregroundColor(/*@START_MENU_TOKEN@*/.orange/*@END_MENU_TOKEN@*/)
                shape.strokeBorder(lineWidth: 1.5).foregroundColor(.orange)
            }
            content
                .opacity(rotation < 90 ? 1 : 0)
        }
        .padding()
        .rotation3DEffect(
            Angle.degrees(rotation),
            axis: (x: 0.0, y: 1.0, z: 0.0)
        )

    }
    
    private struct DrawingConstants {
        static let cornerRadius: CGFloat = 25.0
        static let lineWidth: CGFloat = 1.5
    }

}


extension View{
    func cardify(isFaceUp:Bool) -> some View{
        modifier(Cardify(isFaceUp: isFaceUp))
    }
}
