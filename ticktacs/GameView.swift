//
//  GameView.swift
//  ticktacs
//
//  Created by Patryk Puciłowski on 29/06/2025.
//

import SwiftData
import SwiftUI

struct GameView: View {
    @State private var OTurn: Bool = false

    @State private var CPUPlay: Bool = false

    @State private var winText: String = ""

    @Environment(\.modelContext) private var modelContext

    @State var gameBoard: Game = Game(
        gameID: UUID(),
        creationTime: .now,
    )

    let winningCombinations = [
        [0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8],
        [0, 4, 8], [2, 4, 6],
    ]

    /// for now CPU is the Circle but Bot play
    func playAsCPU() {
        var fieldToMark = Int()

        guard gameBoard.fields.contains(.empty) else {
            print("No empty fields for CPU to play")
            gameBoard.isCompleted = true
            gameBoard.endGameType = .Tie
            winText = "TIE"
            do {
                try modelContext.save()
            } catch {
                print("Failed to save CPU move: \(error)")
            }
            return
        }

        repeat {
            fieldToMark = Int.random(in: 0...8)
        } while gameBoard.fields[fieldToMark] != .empty

        gameBoard.fields[fieldToMark] = .O

        OTurn.toggle()
        checkWinning()
        do {
            try modelContext.save()
        } catch {
            print("Failed to save CPU move: \(error)")
        }
    }

    func checkWinning() {
        for checkedField in winningCombinations {
            if gameBoard.fields[checkedField[0]]
                == gameBoard.fields[checkedField[1]]
                && gameBoard.fields[checkedField[1]]
                    == gameBoard.fields[checkedField[2]]
                && gameBoard.fields[checkedField[0]]
                    != fieldState.empty
            {
                gameBoard.isCompleted = true
                switch gameBoard.fields[checkedField[0]] {
                case .X:
                    gameBoard.endGameType = .X
                case .O:
                    gameBoard.endGameType = .O
                case .empty:
                    continue
                }
                print("\(gameBoard.fields[checkedField[0]]) wins!")
                winText = "\(gameBoard.fields[checkedField[0]]) wins!"

                return
            }
            if gameBoard.fields.allSatisfy({ $0 != fieldState.empty }) {
                gameBoard.isCompleted = true
                gameBoard.endGameType = .Tie
                print("TIE")
                winText = "TIE"
            }
        }
    }

    var body: some View {
        NavigationStack {

            VStack {
                Toggle(isOn: $CPUPlay) {
                    Text("CPU GAMING")
                }
            }

            VStack {
                if !gameBoard.isCompleted {
                    Text("Current turn: \(OTurn ? "O" : "X")")
                        #if !os(watchOS)
                            .font(.title)
                        #endif
                        .bold()
                        .foregroundColor(OTurn ? .blue : .red)
                } else {
                    Text(winText)
                        #if !os(watchOS)
                            .font(.title)
                        #endif
                        .bold()
                }

                LazyVGrid(columns: Array(repeating: GridItem(), count: 3)) {
                    ForEach(gameBoard.fields.indices, id: \.self) { index in
                        Button {
                            if gameBoard.fields[index] == .empty
                                && !gameBoard.isCompleted
                            {
                                gameBoard.fields[index] = OTurn ? .O : .X
                                checkWinning()
                                do {
                                    try modelContext.save()
                                } catch {
                                    print(
                                        "Failed to save Player move: \(error)"
                                    )
                                }
                                OTurn.toggle()

                                if CPUPlay {
                                    playAsCPU()
                                }
                            }
                        } label: {
                            VStack {
                                Text(gameBoard.fields[index].description)
                                    .padding()
                            }
                        }
                        .buttonStyle(.bordered)
                        .buttonBorderShape(.roundedRectangle(radius: 8))
                    }
                }
            }
            .padding()
            .onAppear {
                modelContext.insert(gameBoard)
                checkWinning()
            }
        }
    }
}

#Preview {
    GameView()
}
