import SwiftUI

struct IntroView: View {
    let onStartGame: () -> Void
    let onShowSettings: () -> Void
    let onGoToInterrogation: () -> Void
    
    var body: some View {
        ZStack {
            Image("intro_background")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                HStack {
                    VStack(alignment: .leading, spacing: 20) {
                        VStack(spacing: 12) {
                            Button("OYUNA BAŞLA") {
                                onStartGame()
                            }
                            .buttonStyle(GameButtonStyle())
                            
                            Button("SORGULAMAYA GEÇ") {
                                onGoToInterrogation()
                            }
                            .buttonStyle(GameButtonStyle())
                            
                            Button("AYARLAR") {
                                onShowSettings()
                            }
                            .buttonStyle(GameButtonStyle())
                        }
                    }
                    .padding(.leading, 40)
                    Spacer()
                }
                Spacer()
            }
        }
    }
} 



