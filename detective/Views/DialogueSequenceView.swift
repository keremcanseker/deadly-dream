import SwiftUI

func loadSteps(fromResource resource: String) -> [DialogueStep] {
    guard let url = Bundle.main.url(forResource: resource, withExtension: "json"),
          let data = try? Data(contentsOf: url) else {
        return []
    }
    if resource == "story" {
        if let decoded = try? JSONDecoder().decode(StoryData.self, from: data) {
            return decoded.storySections.flatMap { $0.steps }
        }
    } else if resource == "interregation" {
        if let decoded = try? JSONDecoder().decode(InterrogationData.self, from: data) {
            return decoded.storySections.flatMap { $0.steps }
        }
    }
    return []
}

struct DialogueSequenceView: View {
    let steps: [DialogueStep]
    let onFinished: (() -> Void)?
    
    @StateObject private var typewriter = TypewriterEffect()
    @State private var currentStepIndex: Int = 0
    @State private var currentDialogueIndex: Int = 0
    @State private var showingChoiceResponse = false
    @State private var selectedResponse: ChoiceResponse?
    
    var body: some View {
        ZStack {
            // Arka plan resmi
            if let imageName = currentStep?.image {
                Image(imageName)
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                    .transition(.opacity)
                    .animation(.easeInOut(duration: 0.8), value: imageName)
            } else {
                Color.black.ignoresSafeArea()
            }
            
            if let dialogue = currentDialogue {
                VStack {
                    Spacer()
                    // Dialog kutusu - sadece choices yoksa veya response gösteriliyorsa
                    if !hasChoices || showingChoiceResponse {
                        VStack(alignment: .leading, spacing: 8) {
                            Text(showingChoiceResponse ? (selectedResponse?.speaker ?? "") : dialogue.speaker)
                                .font(.custom("Saira-SemiBold", size: 18))
                                .foregroundColor(.orange)
                            Text(typewriter.visibleText)
                                .font(.custom("Saira-Medium", size: 16))
                                .foregroundColor(.white)
                        }
                        .padding()
                        .background(Color.black.opacity(0.6))
                        .cornerRadius(16)
                        .padding()
                    }
                    // Choice butonları - sadece choices varsa ve response gösterilmiyorsa
                    if hasChoices && !showingChoiceResponse {
                        VStack(spacing: 12) {
                            ForEach(Array((dialogue.playerChoices ?? []).enumerated()), id: \ .offset) { index, choice in
                                Button(action: {
                                    selectChoice(choice)
                                }) {
                                    Text(choice.text)
                                        .multilineTextAlignment(.leading)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                }
                                .buttonStyle(.choiceButton)
                            }
                        }
                        .padding(.horizontal)
                        .padding(.bottom)
                    }
                }
                .onChange(of: currentDialogueIndex) { _ in
                    updateCurrentDialogue()
                }
                .onChange(of: currentStepIndex) { _ in
                    updateCurrentStep()
                }
            } else {
                Text("Yükleniyor...")
                    .foregroundColor(.white)
            }
        }
        .contentShape(Rectangle())
        .onTapGesture {
            handleTap()
        }
        .onAppear {
            updateCurrentStep()
        }
    }
    
    private var currentStep: DialogueStep? {
        steps[safe: currentStepIndex]
    }
    private var currentDialogue: Dialogue? {
        currentStep?.dialogues[safe: currentDialogueIndex]
    }
    private var hasChoices: Bool {
        currentDialogue?.playerChoices?.isEmpty == false
    }
    
    private func handleTap() {
        // Choices varsa ve response gösterilmiyorsa, tap'i ignore et
        if hasChoices && !showingChoiceResponse {
            return
        }
        let textToCheck = showingChoiceResponse ? (selectedResponse?.text ?? "") : (currentDialogue?.text ?? "")
        if typewriter.isTyping {
            typewriter.completeTypewriterEffect(with: textToCheck)
        } else {
            if showingChoiceResponse {
                // Response gösteriliyorsa, sonraki dialogue'a geç
                showingChoiceResponse = false
                selectedResponse = nil
                goToNextDialogue()
            } else {
                goToNextDialogue()
            }
        }
    }
    
    private func selectChoice(_ choice: PlayerChoice) {
        selectedResponse = choice.response
        showingChoiceResponse = true
        typewriter.startTypewriterEffect(for: choice.response.text)
    }
    
    private func goToNextDialogue() {
        guard let step = currentStep else { return }
        // Mevcut step'teki sonraki diyaloga geç
        if currentDialogueIndex < step.dialogues.count - 1 {
            currentDialogueIndex += 1
            return
        }
        // Sonraki step'e geç
        if currentStepIndex < steps.count - 1 {
            currentStepIndex += 1
            currentDialogueIndex = 0
            return
        }
        // Tüm akış bitti
        onFinished?()
    }
    
    private func updateCurrentStep() {
        currentDialogueIndex = 0
        updateCurrentDialogue()
    }
    private func updateCurrentDialogue() {
        showingChoiceResponse = false
        selectedResponse = nil
        if let dialogue = currentDialogue {
            typewriter.startTypewriterEffect(for: dialogue.text)
        }
    }
}

// Güvenli dizi erişimi için extension
extension Collection {
    subscript(safe index: Index) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
} 