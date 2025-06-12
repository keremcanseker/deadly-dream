import SwiftUI

struct StoryView: View {
    @ObservedObject var viewModel: StoryViewModel
    let onStoryFinished: () -> Void
    
    // Typewriter effect state
    @State private var visibleText: String = ""
    @State private var typewriterTimer: Timer?
    @State private var currentCharacterIndex: Int = 0

    var body: some View {
        ZStack {
            if let image = viewModel.currentImage {
                Image(image)
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                    .transition(.opacity)
                    .animation(.easeInOut(duration: 0.8), value: image)
            }

            if let dialogue = viewModel.currentDialogue {
                VStack {
                    Spacer()
                    
                    // Only show dialogue box if we DON'T have choices OR we're showing a choice response
                    if !viewModel.hasChoices || viewModel.showingChoiceResponse {
                        VStack(alignment: .leading, spacing: 8) {
                            Text(dialogue.speaker)
                                .font(.custom("Saira-SemiBold", size: 18))
                                .foregroundColor(.orange)
                            Text(visibleText)
                                .font(.custom("Saira-Medium", size: 16))
                                .foregroundColor(.white)
                        }
                        .padding()
                        .background(Color.black.opacity(0.6))
                        .cornerRadius(16)
                        .padding()
                        .onAppear {
                            startTypewriterEffect(for: dialogue.text)
                        }
                        .onChange(of: dialogue.text) { newText in
                            startTypewriterEffect(for: newText)
                        }
                    }
                    
                    // Choice buttons - only show if we have choices and not showing response
                    if viewModel.hasChoices && !viewModel.showingChoiceResponse {
                        VStack(spacing: 12) {
                            ForEach(Array(viewModel.playerChoices.enumerated()), id: \.offset) { index, choice in
                                Button(action: {
                                    viewModel.selectChoice(choice)
                                }) {
                                    Text(choice.text)
                                        .font(.custom("Saira-Medium", size: 14))
                                        .foregroundColor(.white)
                                        .multilineTextAlignment(.leading)
                                        .padding()
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .background(Color.blue.opacity(0.7))
                                        .cornerRadius(12)
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                }
            }
        }
        .contentShape(Rectangle())
        .onTapGesture {
            // Don't allow tap to advance if we're waiting for choice selection
            if viewModel.hasChoices && !viewModel.showingChoiceResponse {
                return
            }
            
            // If typewriter effect is in progress, complete it immediately
            if let dialogue = viewModel.currentDialogue, visibleText != dialogue.text {
                completeTypewriterEffect()
            } else {
                // Otherwise, advance to next dialogue
                viewModel.next()
                if viewModel.isFinished {
                    onStoryFinished()
                }
            }
        }
        .onDisappear {
            stopTypewriterEffect()
        }
    }
    
    private func startTypewriterEffect(for text: String) {
        stopTypewriterEffect()
        visibleText = ""
        currentCharacterIndex = 0
        
        typewriterTimer = Timer.scheduledTimer(withTimeInterval: 0.025, repeats: true) { timer in
            if currentCharacterIndex < text.count {
                let index = text.index(text.startIndex, offsetBy: currentCharacterIndex)
                visibleText = String(text[...index])
                currentCharacterIndex += 1
            } else {
                timer.invalidate()
                typewriterTimer = nil
            }
        }
    }
    
    private func completeTypewriterEffect() {
        if let dialogue = viewModel.currentDialogue {
            stopTypewriterEffect()
            visibleText = dialogue.text
        }
    }
    
    private func stopTypewriterEffect() {
        typewriterTimer?.invalidate()
        typewriterTimer = nil
    }
}
