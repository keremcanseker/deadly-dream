//
//  detectiveApp.swift
//  detective
//
//  Created by Keremcan Şeker on 8.06.2025.
//

import SwiftUI

@main
struct detectiveApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
