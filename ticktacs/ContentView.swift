//
//  ContentView.swift
//  ticktacs
//
//  Created by Patryk Puciłowski on 25/06/2025.
//

import SwiftUI

struct ContentView: View {
    @State private var game: [field] = []

    @State private var OTurn: Bool = false

    @State private var gameStop: Bool = false

    @State private var winText: String = ""

    func makeField() {
        let length = 0...8

        for i in length {
            let field = field(fieldId: i, state: .empty)
            game.append(field)
        }
    }

    let winningCombinations = [
        [0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8],
        [0, 4, 8], [2, 4, 6],
    ]

    func checkWinning() {
        for combo in winningCombinations {
            if game[combo[0]].state == game[combo[1]].state
                && game[combo[1]].state == game[combo[2]].state
                && game[combo[0]].state != .empty
            {
                gameStop = true
                print("\(game[combo[0]].state) wins!")
                winText = "\(game[combo[0]].state) wins!"
                return
            }
        }
    }

    var body: some View {
        VStack {
            if !gameStop {
                Text("Current turn: \(OTurn ? "O" : "X")")
                    .font(.title)
                    .bold()
                    .foregroundColor(OTurn ? .blue : .red)
            } else {
                Text(winText)
                    .font(.title)
                    .bold()
            }

            LazyVGrid(columns: Array(repeating: GridItem(), count: 3)) {
                ForEach(game) { field in
                    Button {
                        if field.state == .empty && !gameStop {
                            if !OTurn {
                                field.state = .X
                                checkWinning()
                            } else {
                                field.state = .O
                                checkWinning()
                            }
                            OTurn.toggle()
                        }
                    } label: {
                        Text("\(field.fieldId)")
                        Text("\(field.state.description)")
                    }

                }
            }

        }
        .padding()
        .onAppear(perform: makeField)
    }
}

#Preview {
    ContentView()
}
