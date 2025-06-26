//
//  field.swift
//  ticktacs
//
//  Created by Patryk Puciłowski on 25/06/2025.
//

import Foundation

@Observable
class field: Identifiable {
    var fieldId: Int
    var state: fieldState = .empty
    init(fieldId: Int, state: fieldState) {
        self.fieldId = fieldId
        self.state = state
    }
}

enum fieldState {
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
