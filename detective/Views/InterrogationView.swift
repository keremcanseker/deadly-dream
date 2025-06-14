import SwiftUI

struct InterrogationView: View {
    @StateObject private var typewriter = TypewriterEffect()
    @State private var interrogationData: InterrogationData?
    @State private var currentDialogueIndex: Int = 0
    @State private var currentStepIndex: Int = 0
    @State private var currentSectionIndex: Int = 0
    @State private var currentStep: InterrogationStep?
    @State private var currentSection: InterrogationSection?
    @State private var isLoaded = false
    @State private var showingChoiceResponse = false
    @State private var selectedResponse: ChoiceResponse?
    
    let onInterrogationFinished: (() -> Void)?
    
    init(onInterrogationFinished: (() -> Void)? = nil) {
        self.onInterrogationFinished = onInterrogationFinished
    }
    
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
                            ForEach(Array((dialogue.playerChoices ?? []).enumerated()), id: \.offset) { index, choice in
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
                .onAppear {
                    if !isLoaded {
                        loadInterrogation()
                    }
                }
                .onChange(of: currentDialogueIndex) { _ in
                    updateCurrentDialogue()
                }
                .onChange(of: currentStepIndex) { _ in
                    updateCurrentStep()
                }
                .onChange(of: currentSectionIndex) { _ in
                    updateCurrentSection()
                }
            } else {
                Text("Sorgu Yükleniyor...")
                    .foregroundColor(.white)
                    .onAppear {
                        if !isLoaded {
                            loadInterrogation()
                        }
                    }
            }
        }
        .contentShape(Rectangle())
        .onTapGesture {
            handleTap()
        }
    }
    
    private var currentDialogue: InterrogationDialogue? {
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
        guard let interrogationData = interrogationData else { return }
        guard let step = currentStep else { return }
        
        // Mevcut step'teki sonraki diyaloga geç
        if currentDialogueIndex < step.dialogues.count - 1 {
            currentDialogueIndex += 1
            return
        }
        
        // Mevcut section'daki sonraki step'e geç
        if let section = currentSection,
           currentStepIndex < section.steps.count - 1 {
            currentStepIndex += 1
            currentDialogueIndex = 0
            return
        }
        
        // Sonraki section'a geç
        if currentSectionIndex < interrogationData.storySections.count - 1 {
            currentSectionIndex += 1
            currentStepIndex = 0
            currentDialogueIndex = 0
            return
        }
        
        // Sorgu bitti
        onInterrogationFinished?()
    }
    
    private func updateCurrentSection() {
        guard let interrogationData = interrogationData else { return }
        currentSection = interrogationData.storySections[safe: currentSectionIndex]
        updateCurrentStep()
    }
    
    private func updateCurrentStep() {
        guard let section = currentSection else { return }
        currentStep = section.steps[safe: currentStepIndex]
        updateCurrentDialogue()
    }
    
    private func updateCurrentDialogue() {
        showingChoiceResponse = false
        selectedResponse = nil
        
        if let dialogue = currentDialogue {
            typewriter.startTypewriterEffect(for: dialogue.text)
        }
    }
    
    private func loadInterrogation() {
        guard let url = Bundle.main.url(forResource: "interregation", withExtension: "json"),
              let data = try? Data(contentsOf: url),
              let decoded = try? JSONDecoder().decode(InterrogationData.self, from: data) else {
            return
        }
        self.interrogationData = decoded
        
        // İlk section, step ve dialogue'u ayarla
        currentSectionIndex = 0
        currentStepIndex = 0
        currentDialogueIndex = 0
        
        updateCurrentSection()
        self.isLoaded = true
    }
}

