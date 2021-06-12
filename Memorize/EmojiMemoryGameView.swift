//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Nicola Mastrandrea on 27/05/21.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var game: EmojiMemoryGame
    @State var minZoom: CGFloat = 100
    
    var body: some View {
        VStack{
            HStack{
                Text("Current Score: \(game.model.current_score)")
                Spacer()
                Text("Best score: \(game.model.scores.min() ?? 0)")
            }.padding(.all)
            
            AspectVGrid(items: game.model.cards.filter {!$0.isMatched},aspectRatio: 2/3) {cardView(for: $0)}
            
            Spacer()
            
            HStack{
                Button(action: {
                    game.reset()
                }, label: {
                    Text("New Game")
                        .font(.title)
                })
            }.padding(.vertical)
        }
    }
    
    @ViewBuilder
    private func cardView(for card: EmojiMemoryGame.Card) -> some View {
        if card.isMatched && !card.isFacedUp{
            Rectangle().opacity(0)
        } else {
            CardView(card: card)
                .onTapGesture {
                    game.choose(card)
                }
            .padding()
        }
        }
}


struct CardView: View {
    let card: MemoryGame<String>.Card
    
    var body: some View{
        GeometryReader(content: { geometry in
            ZStack {
                    Pie(startAngle: Angle(degrees: -90), endAngle: Angle(degrees: 20), clockWise: false)
                        .padding(DrawingConstants.circlePadding)
                        .opacity(DrawingConstants.circleOpacity)
                    Text(card.content).font(getFont(in: geometry.size))
                }
            .cardify(isFacedUp: card.isFacedUp)
        })
    }
        
    private func getFont(in size:CGSize) -> Font {
        Font.system(size: (DrawingConstants.fontScale * min(size.width,size.height)))
    }
    
    private struct DrawingConstants {
        static let cornerRadius: CGFloat = 25.0
        static let lineWidth: CGFloat = 1.5
        static let fontScale: CGFloat = 0.5
        static let circlePadding: CGFloat = 5
        static let circleOpacity: Double = 0.5
    }
}











struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        game.choose(game.model.cards.first!)
        return EmojiMemoryGameView(game: game)
            .previewDevice("iPhone 12 Pro")
            .preferredColorScheme(.dark)
    }
}
