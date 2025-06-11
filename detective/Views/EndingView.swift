import SwiftUI

struct EndingView: View {
    let ending: EndingSection
    let isCorrect: Bool

    var body: some View {
        ZStack {
            if let image = ending.image {
                Image(image)
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
            } else {
                Color.black.ignoresSafeArea()
            }

            VStack {
                Text(isCorrect ? "Doğru Tahmin!" : "Yanlış Kişiyi Suçladın...")
                    .font(.custom("Saira-SemiBold", size: 24))
                    .foregroundColor(.white)
                    .padding()

                Text(ending.narration)
                    .font(.custom("Saira-Medium", size: 16))
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.black.opacity(0.6))
                    .cornerRadius(16)
                    .padding()

                if let audio = ending.audio {
                    Text("🎵 \(audio)") // gerçek uygulamada ses oynatılır
                        .font(.custom("Saira-Medium", size: 14))
                        .foregroundColor(.gray)
                        .italic()
                        .padding(.top)
                }
            }
        }
    }
} 