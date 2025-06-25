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

    func makeField() {
        let length = 1...9

        for i in length {
            let field = field(fieldId: i, state: .empty)
            game.append(field)
        }
    }

    var body: some View {
        VStack {
            LazyVGrid(columns: Array(repeating: GridItem(), count: 3)) {
                ForEach(game) { field in
                    Button {
                        if field.state == .empty && !OTurn {
                            field.state = .X
                            OTurn.toggle()
                        } else if field.state == .empty && OTurn {
                            field.state = .O
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
