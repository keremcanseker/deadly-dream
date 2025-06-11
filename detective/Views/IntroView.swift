import SwiftUI

struct IntroView: View {
    let intro: IntroSection?
    let onStart: () -> Void
    let onSettings: () -> Void

    var body: some View {
        ZStack {
            if let background = intro?.background {
                Image(background)
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
            } else {
                Color.black.ignoresSafeArea()
            }

            VStack(spacing: 32) {
                Spacer()
                if let text = intro?.text {
                    Text(text)
                        .font(.title2)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.black.opacity(0.6))
                        .cornerRadius(16)
                        .padding(.horizontal)
                }
                Spacer()
                HStack(spacing: 24) {
                    Button(action: onStart) {
                        Text("Start Game")
                            .font(.headline)
                            .padding(.horizontal, 32)
                            .padding(.vertical, 16)
                            .background(Color.white.opacity(0.8))
                            .foregroundColor(.black)
                            .cornerRadius(12)
                    }
                    Button(action: onSettings) {
                        Text("Settings")
                            .font(.headline)
                            .padding(.horizontal, 32)
                            .padding(.vertical, 16)
                            .background(Color.gray.opacity(0.7))
                            .foregroundColor(.white)
                            .cornerRadius(12)
                    }
                }
                Spacer().frame(height: 40)
            }
        }
    }
} 