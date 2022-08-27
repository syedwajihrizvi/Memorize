//
//  ContentView.swift
//  MemorizerGame
//
//  Created by Wajih Rizvi on 2022-08-18.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    var body: some View {
        VStack {
            HStack {
                score
                Spacer()
                newGame
            }
            Text(viewModel.theme.name).font(.largeTitle)
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 80))]) {
                    ForEach(viewModel.cards) { card in
                        CardView(card: card, color: viewModel.currentColor)
                            .aspectRatio(2/3, contentMode: .fit)
                            .onTapGesture {
                                print(viewModel.choose(card))
                            }
                    }
                }
                .foregroundColor(.red)
                .padding(10)
            }
            ScrollView(.horizontal) {
                HStack(spacing: 10) {
                    ForEach(viewModel.themes) {theme in
                        ThemeView(name: theme.name, label: theme.label)
                            .onTapGesture {
                                viewModel.selectTheme(theme)
                            }
                    }
                }
                .padding(.horizontal)
                
            }
            
        }
    }
    
    var score: some View {
        Text("Score: " + String(viewModel.score))
            .font(.largeTitle)
            .fontWeight(.bold)
            .padding(.leading)
    }

    var newGame: some View {
        Button(action: {
            viewModel.newGame()
        }, label: {
            VStack {
                Text("New")
                Text("Game")
            }
            .font(.headline)
        })
            .padding(.trailing)
    }
}

struct ThemeView: View {
    let name: String
    let label: String

    var body: some View {
        VStack {
            Text(label)
            Text(name)
                .fontWeight(.heavy)
        }
        .padding(.horizontal)
        .font(.largeTitle)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        ContentView(viewModel: game)
            .preferredColorScheme(.light)
        ContentView(viewModel: game)
            .preferredColorScheme(.dark)
    }
}

struct CardView: View {
    var card: MemoryGame<String>.Card
    var color: Color
    var body: some View {
        ZStack(content:  {
            let shape = RoundedRectangle(cornerRadius: 10)
            if card.isFaceUp {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: 3).foregroundColor(color)
                Text(card.content).bold()
            } else if card.isMatched {
                shape.opacity(0)
            }
            else {
                shape.fill().foregroundColor(color)
            }
        })
    }
}
