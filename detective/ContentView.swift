//
//  ContentView.swift
//  detective
//
//  Created by Keremcan Şeker on 8.06.2025.
//

import SwiftUI

struct DarkButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.custom("Saira-SemiBold", size: 18))
            .foregroundColor(.white)
            .padding(.vertical, 18)
            .padding(.horizontal, 32)
            .background(Color.black.opacity(configuration.isPressed ? 0.8 : 0.6))
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color.cyan.opacity(0.7), lineWidth: 2)
            )
            .cornerRadius(16)
            .shadow(color: Color.cyan.opacity(0.4), radius: 10, x: 0, y: 4)
            .scaleEffect(configuration.isPressed ? 0.97 : 1.0)
            .animation(.easeOut(duration: 0.15), value: configuration.isPressed)
    }
}

struct ContentView: View {
    @State private var scenario: Scenario?
    @State private var errorMessage: String?
    @State private var isLoading = true

    var body: some View {
        Group {
            if isLoading {
                VStack {
                    ProgressView()
                    Text("Senaryo yükleniyor...")
                        .font(.custom("Saira-Medium", size: 16))
                        .padding(.top, 8)
                }
            } else if let scenario = scenario {
                GameRootView(coordinator: GameCoordinatorViewModel(scenario: scenario))
            } else if let errorMessage = errorMessage {
                VStack(spacing: 16) {
                    Text("Hata: \(errorMessage)")
                        .font(.custom("Saira-Medium", size: 16))
                        .foregroundColor(.red)
                        .multilineTextAlignment(.center)
                    Button("Tekrar Dene") {
                        loadScenario()
                    }
                    .font(.custom("Saira-SemiBold", size: 16))
                }
                .padding()
            }
        }
        .onAppear {
            loadScenario()
        }
    }

    private func loadScenario() {
        isLoading = true
        errorMessage = nil
        DispatchQueue.global(qos: .userInitiated).async {
            do {
                let loaded = try ScenarioLoader.loadScenario()
                DispatchQueue.main.async {
                    self.scenario = loaded
                    self.isLoading = false
                }
            } catch {
                DispatchQueue.main.async {
                    self.errorMessage = error.localizedDescription
                    self.isLoading = false
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
