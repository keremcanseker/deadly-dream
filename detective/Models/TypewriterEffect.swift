import Foundation
import SwiftUI

@MainActor
final class TypewriterEffect: ObservableObject {
    @Published var visibleText: String = ""
    @Published var isTyping: Bool = false
    
    private var typewriterTimer: Timer?
    
    func startTypewriterEffect(for text: String) {
        stopTypewriterEffect()
        visibleText = ""
        isTyping = true
        
        var currentIndex = 0
        typewriterTimer = Timer.scheduledTimer(withTimeInterval: 0.025, repeats: true) { [weak self] timer in
            guard let self = self else {
                timer.invalidate()
                return
            }
            
            if currentIndex < text.count {
                let index = text.index(text.startIndex, offsetBy: currentIndex)
                self.visibleText = String(text[...index])
                currentIndex += 1
            } else {
                timer.invalidate()
                self.typewriterTimer = nil
                self.isTyping = false
            }
        }
    }
    
    func completeTypewriterEffect(with text: String) {
        stopTypewriterEffect()
        visibleText = text
        isTyping = false
    }
    
    private func stopTypewriterEffect() {
        typewriterTimer?.invalidate()
        typewriterTimer = nil
    }
} 