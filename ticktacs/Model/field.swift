//
//  field.swift
//  ticktacs
//
//  Created by Patryk Puciłowski on 25/06/2025.
//

import Foundation
import SwiftData

@Model
class Game: Identifiable {
    var gameID: UUID
    var fields: [fieldState]
    var creationTime: Date
    var isCompleted: Bool
    var endGameType: EndGameTypes?
    var gameStyle: GameStyles?
    
    func reset() {
        self.fields = Array(repeating: .empty, count: 9)
    }

    init(gameID: UUID, creationTime: Date) {
        self.gameID = gameID
        self.fields = Array(repeating: .empty, count: 9)
        self.creationTime = creationTime
        self.isCompleted = false
    }
}

enum fieldState: Codable {
    case empty, X, O

    var description: String {
        switch self {
        case .empty:
            return " "
        case .X:
            return "X"
        case .O:
            return "O"
        }
    }
}

enum EndGameTypes: Codable {
    case X,O,Tie
    
    var description: String {
        switch self {
        case .X:
            return "X"
        case .O:
            return "O"
        case .Tie:
            return "TIE"
        }
    }
}

enum GameStyles: Codable {
    case singlePlayerCPU, localMultiplayer, onlineMultiplayer
}
