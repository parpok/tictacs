//
//  ticktacsApp.swift
//  ticktacs
//
//  Created by Patryk Puciłowski on 25/06/2025.
//

import SwiftData
import SwiftUI

@main
struct ticktacsApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: Game.self)
                #if os(macOS)
                .containerBackground(.thinMaterial, for: .window)
                .presentedWindowStyle(.hiddenTitleBar)
                #endif
            #if os(VisionOS)
                .containerBackground(.thinMaterial, for: .navigation)
            #endif
        }
    }
}
