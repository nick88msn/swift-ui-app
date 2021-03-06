//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Nicola Mastrandrea on 27/05/21.
//

import SwiftUI

@main
struct MemorizeApp: App {
    private let game = EmojiMemoryGame()

    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(game: game)
        }
    }
}
