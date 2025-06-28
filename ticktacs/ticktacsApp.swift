//
//  ticktacsApp.swift
//  ticktacs
//
//  Created by Patryk Puciłowski on 25/06/2025.
//

import SwiftUI
import SwiftData

@main
struct ticktacsApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: Game.self)
        }
    }
}
