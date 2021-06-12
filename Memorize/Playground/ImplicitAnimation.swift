//
//  ImplicitAnimation.swift
//  Memorize
//
//  Created by Nicola Mastrandrea on 08/06/21.
//

import SwiftUI

struct AnimationView: View {
    @State var isScary: Bool = true
    @State var isUpsideDown: Bool = false
    
    var body: some View {
        VStack{
            Spacer()
            Text(isScary ? "👻" : "😱")
                .font(.largeTitle)
                .opacity(isScary ? 1 : 0)
                .rotationEffect(Angle.degrees(isUpsideDown ? 180 : 0))
                .animation(.easeInOut)

            Button(action: {
                withAnimation{
                    isScary.toggle()
                    isUpsideDown.toggle()
                }
            }, label: {
                    Text(isScary ? "Press me" : "Bring me back")
            })
            .padding()
            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
            .foregroundColor(isScary ? .primary : .secondary)
            .border(Color.primary, width: isScary ? 0.5 : 2)
            //.scaleEffect()
            //.animation(.easeInOut)

            Spacer()
        }
    }
}


struct AnimationView_Previews: PreviewProvider {
    static var previews: some View {
        return AnimationView()
            .previewDevice("iPhone 12 Pro")
            .preferredColorScheme(.dark)
    }
}
