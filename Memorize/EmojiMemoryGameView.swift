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
    
    @State private var dealt = Set<Int>()
    
    private func deal(_ card: EmojiMemoryGame.Card) {
        dealt.insert(card.id)
    }
    
    private func isUndealt(_ card: EmojiMemoryGame.Card) -> Bool {
        return !dealt.contains(card.id)
    }
    
    var body: some View {
        VStack{
            actionView
            AspectVGrid(items: game.model.cards,aspectRatio: 2/3, content: {cardView(for: $0)})
            Spacer()
            scoreView
            deckBody
        }
    }
    
    var actionView: some View {
        HStack{
            newGameButton
            Spacer()
            shuffleButton
        }.padding(.all)
    }
    
    var scoreView: some View {
        HStack{
            Text("Current Score: \(game.model.current_score)")
            Spacer()
            Text("Best score: \(game.model.scores.min() ?? 0)")
        }.padding(.all)
    }
    
    var deckBody: some View {
        ZStack{
            ForEach(game.model.cards.filter(isUndealt)){ card in
                CardView(card: card)
                    .transition(AnyTransition.scale.animation(.easeIn(duration: 2)))
            }
        }
        .frame(width: CardCostants.undealtWidth, height: CardCostants.undealtHeight)
        .foregroundColor(CardCostants.color)
        .onTapGesture {
            withAnimation {
                for card in game.model.cards {
                    deal(card)
                }
            }
        }

    }

    var newGameButton: some View{
        HStack{
            Button(action: {
                withAnimation{
                    game.reset()
                }
            }, label: {
                Text("New Game")
                    .font(.title3)
            })
        }
    }
    
    var shuffleButton: some View {
        Button(action: {
            withAnimation {
                game.shuffle()
            }
        }, label: {
            Text("Shuffle")
                .font(.title3)
        })
    }
    
    private struct CardCostants {
        static let color = Color.red
        static let aspectRatio: CGFloat = 2/3
        static let dealDuration: Double = 0.5
        static let totalDealDuration: Double = 2
        static let undealtHeight: CGFloat = 90
        static let undealtWidth: CGFloat = undealtHeight * aspectRatio
    }
    
    
    @ViewBuilder
    private func cardView(for card: EmojiMemoryGame.Card) -> some View {
        if isUndealt(card) || (card.isMatched && !card.isFacedUp){
            //Rectangle().opacity(0)
            Color.clear
        } else {
            CardView(card: card)
                .transition(AnyTransition.asymmetric(insertion: .scale, removal: .opacity).animation(.easeInOut(duration: 2)))
                .onTapGesture {
                    withAnimation(.easeInOut){
                        game.choose(card)
                    }
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
                        .rotationEffect(Angle.degrees(card.isMatched ? 360 : 0))
                        .animation(.linear(duration:3))

                    Text(card.content)
                        //.font(getFont(in: geometry.size)) //using variable font with animation makes some junky cases
                        .font(Font.system(size: DrawingConstants.fontSize))
                        .scaleEffect(scale(thatFits: geometry.size))
                }
            .cardify(isFaceUp: card.isFacedUp)
        })
    }
        
    private func scale(thatFits size: CGSize) -> CGFloat{
        min(size.width, size.height) / (DrawingConstants.fontSize / DrawingConstants.fontScale)
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
        static let fontSize: CGFloat = 32
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
