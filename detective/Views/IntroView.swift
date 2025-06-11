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

            // Butonları sol tarafa yerleştir
            VStack {
                Spacer()
                
                HStack {
                    VStack(spacing: 20) {
                        Button(action: onStart) {
                            Text("OYUNA BAŞLA")
                                .font(.custom("Saira-SemiBold", size: 18))
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .padding(.horizontal, 24)
                                .padding(.vertical, 16)
                                .frame(width: 180)
                        }
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color.black.opacity(0.6))
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.white.opacity(0.3), lineWidth: 1)
                        )
                        .shadow(color: Color.blue.opacity(0.4), radius: 8)

                        Button(action: onSettings) {
                            Text("AYARLAR")
                                .font(.custom("Saira-SemiBold", size: 18))
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .padding(.horizontal, 24)
                                .padding(.vertical, 16)
                                .frame(width: 180)
                        }
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color.black.opacity(0.6))
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.white.opacity(0.3), lineWidth: 1)
                        )
                        .shadow(color: Color.blue.opacity(0.4), radius: 8)
                    }
                    .padding(.leading, 40)
                    
                    Spacer()
                }
                
                Spacer()
            }
        }
    }
} 
