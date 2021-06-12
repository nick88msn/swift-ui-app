//
//  MemoryGame.swift
//  Memorize
//
//  Created by Nicola Mastrandrea on 28/05/21.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable{
    private(set) var cards: Array<Card>
    private(set) var current_score: Int
    private(set) var scores: Array<Int>
    
    private var indexFacedUpCard: Int? {
        get{ cards.indices.filter({cards[$0].isFacedUp == true}).oneAndOnly }
        set{ cards.indices.forEach{cards[$0].isFacedUp = ( $0 == newValue )} }
        }
        
    mutating func choose(_ card: Card){
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }),
           !cards[chosenIndex].isFacedUp,
           !cards[chosenIndex].isMatched{
            if let potentialMatch = indexFacedUpCard {
                if cards[chosenIndex].content == cards[potentialMatch].content{
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatch].isMatched = true
                }
                cards[chosenIndex].isFacedUp = true
                current_score += 1
            } else {
                indexFacedUpCard = chosenIndex
            }
        }
    }
    
    mutating func reset(){
        if cards.allSatisfy({$0.isMatched == true}){
            scores.append(current_score)
        }
        current_score = 0

        for index in cards.indices{
            cards[index].isMatched = false
            cards[index].isFacedUp = false
        }
        cards.shuffle()
    }
        
    init(numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent) {
        cards = []
        // number of cards to pair * 2 array of cards
        for pairIndex in 0..<numberOfPairsOfCards{
            let content = createCardContent(pairIndex)
            cards.append(Card(id: pairIndex * 2, content: content))
            cards.append(Card(id: pairIndex * 2 + 1,content: content))
            cards.shuffle()
        }
        current_score = 0
        scores = []
        
    }
    
    struct Card: Identifiable {
        let id: Int
        var isFacedUp = false
        var isMatched = false
        let content: CardContent
    }

}

extension Array {
    var oneAndOnly: Element? {
        if self.count == 1 {
            return self.first
        } else {
            return nil
        }
    }
}
