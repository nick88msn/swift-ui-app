//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Nicola Mastrandrea on 28/05/21.
//

import SwiftUI


class EmojiMemoryGame: ObservableObject  {
    
    typealias Card = MemoryGame<String>.Card
    
    private static let emojis = ["🤯","🤦‍♂️","🤞", "🏖", "💩", "📩", "😃", "🤷‍♂️", "💻", "👍", "💦", "✔️", "☕️", "📈", "💁‍♂️", "🎭", "🐶", "💧", "🖥", "🍷", "😎", "😱", "🏫", "🫖", "🏝", "😂"]
    
    private static func createMemoryGame() -> MemoryGame<String> {
        MemoryGame<String>(numberOfPairsOfCards: 4) { pairIndex in emojis[pairIndex] }
    }
    
    @Published private(set) var model = createMemoryGame()
    
    func choose(_ card: Card){
        model.choose(card)
    }
    
    func reset(){
        model.reset()
    }
    
    func shuffle(){
        model.shuffle()
    }
        
}
