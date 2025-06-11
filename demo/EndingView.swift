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
                    .font(.title)
                    .foregroundColor(.white)
                    .padding()

                Text(ending.narration)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.black.opacity(0.6))
                    .cornerRadius(16)
                    .padding()

                if let audio = ending.audio {
                    Text("🎵 \(audio)") // gerçek uygulamada ses oynatılır
                        .foregroundColor(.gray)
                        .italic()
                        .padding(.top)
                }
            }
        }
    }
}
