import SwiftUI

struct DisclaimerIntroView: View {
    let introText: String
    let onComplete: () -> Void
    
    @State private var showDisclaimer = true
    @State private var showIntroText = false
    @State private var disclaimerOpacity: Double = 0
    @State private var introTextOpacity: Double = 0
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            if showDisclaimer {
                VStack(spacing: 20) {
                    Text("Bu oyun tamamen kurgudur.")
                        .font(.custom("Saira-Medium", size: 18))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                    
                    Text("Gerçek kişi ve olaylarla ilgisi yoktur.")
                        .font(.custom("Saira-Medium", size: 16))
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                }
                .opacity(disclaimerOpacity)
            }
            
            if showIntroText {
                Text(introText)
                    .font(.custom("Saira-Medium", size: 20))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 40)
                    .opacity(introTextOpacity)
            }
        }
        .onAppear {
            startSequence()
        }
    }
    
    private func startSequence() {
        // Disclaimer fade in
        withAnimation(.easeIn(duration: 0.5)) {
            disclaimerOpacity = 1.0
        }
        
        // Disclaimer fade out, intro text fade in
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            withAnimation(.easeOut(duration: 1.0)) {
                disclaimerOpacity = 0.0
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                showDisclaimer = false
                showIntroText = true
                
                withAnimation(.easeIn(duration: 1.5)) {
                    introTextOpacity = 1.0
                }
                
                // Complete after showing intro text
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    withAnimation(.easeOut(duration: 1.0)) {
                        introTextOpacity = 0.0
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                        onComplete()
                    }
                }
            }
        }
    }
} 