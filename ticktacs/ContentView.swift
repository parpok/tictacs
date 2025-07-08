//
//  ContentView.swift
//  ticktacs
//
//  Created by Patryk Puciłowski on 25/06/2025.
//

import SwiftData
import SwiftUI

struct ContentView: View {

    @Query(sort: \Game.creationTime, order: .reverse) var games: [Game]
    @Environment(\.modelContext) private var modelContext
    @State var CPUPlay: Bool = false

    var body: some View {
        NavigationStack {

            List {
                Section {
                    Toggle("Single player game with CPU", isOn: $CPUPlay)
                    NavigationLink(
                        destination: GameView(
                            CPUPlay: CPUPlay,
                            gameBoard: Game(gameID: UUID(), creationTime: .now)
                        )
                    ) {
                        Text("NEW GAME")
                    }
                }
                if !games.isEmpty {
                    Section("Previous games") {
                        ForEach(games) { game in

                            NavigationLink(
                                destination: GameView(gameBoard: game)
                            ) {
                                Text("Game \(game.creationTime)")
                                Text(game.endGameType?.description ?? "Ongoing")
                                    .bold()
                            }
                            .swipeActions {
                                Button(
                                    "Delete",
                                    systemImage: "trash",
                                    role: .destructive
                                ) {
                                    modelContext.delete(game)
                                }
                            }
                            #if os(macOS)
                                .contextMenu {
                                    Button(
                                        "Delete",
                                        systemImage: "trash",
                                        role: .destructive
                                    ) {
                                        modelContext.delete(game)
                                    }
                                }
                            #endif
                        }
                    }
                }
            }
            .navigationTitle("tictacs")

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
