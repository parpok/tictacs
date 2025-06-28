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
    
    func reset() {
        self.fields = Array(repeating: .empty, count: 9)
    }

    init(gameID: UUID, creationTime: Date) {
        self.gameID = gameID
        self.fields = Array(repeating: .empty, count: 9)
        self.creationTime = creationTime
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
