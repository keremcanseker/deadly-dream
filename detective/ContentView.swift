//
//  ContentView.swift
//  detective
//
//  Created by Keremcan Şeker on 8.06.2025.
//

import SwiftUI


struct ContentView: View {
    @StateObject var coordinator = GameCoordinatorViewModel()
    @State private var showSettings = false

    var body: some View {
        GameView()
    }
}


#Preview {
    ContentView()
}
