import SwiftUI

struct SettingsView: View {
    let onClose: () -> Void

    var body: some View {
        ZStack {
            Color(.systemGray6).ignoresSafeArea()
            VStack(spacing: 32) {
                Text("Ayarlar")
                    .font(.largeTitle)
                    .padding(.top, 40)
                Spacer()
                Button(action: onClose) {
                    Text("Kapat")
                        .font(.headline)
                        .padding(.horizontal, 32)
                        .padding(.vertical, 16)
                        .background(Color.blue.opacity(0.8))
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
                Spacer().frame(height: 40)
            }
        }
    }
} 