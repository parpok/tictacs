//
//  ContentView.swift
//  ticktacs
//
//  Created by Patryk Puciłowski on 25/06/2025.
//

import SwiftData
import SwiftUI

struct ContentView: View {

    @Query var games: [Game]

    var body: some View {
        NavigationStack {

            NavigationLink(
                destination: GameView(
                    gameBoard: Game(gameID: UUID(), creationTime: .now)
                )
            ) {
                Text("NEW GAME")
            }

            ForEach(games) { game in
                NavigationLink(destination: GameView(gameBoard: game)) {
                    Text("Game \(game.creationTime)")
                }
            }
        }
//        .onAppear {
//            if !games[0].isCompleted{
//                
//            }
//        }
    }
}

#Preview {
    ContentView()
}
