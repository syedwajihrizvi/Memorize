//
//  MemorizerGameApp.swift
//  MemorizerGame
//
//  Created by Wajih Rizvi on 2022-08-18.
//

import SwiftUI

@main
struct MemorizerGameApp: App {
    let game = EmojiMemoryGame()
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: game)
        }
    }
}
 
