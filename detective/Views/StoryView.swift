import SwiftUI

struct StoryView: View {
    @StateObject private var typewriter = TypewriterEffect()
    @State private var storyData: StoryData?
    @State private var currentDialogueIndex: Int = 0
    @State private var currentStepIndex: Int = 0
    @State private var currentSectionIndex: Int = 0
    @State private var currentStep: StoryStep?
    @State private var currentSection: StorySection?
    @State private var isLoaded = false
    
    let onStoryFinished: (() -> Void)?
    
    init(onStoryFinished: (() -> Void)? = nil) {
        self.onStoryFinished = onStoryFinished
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
                    VStack(alignment: .leading, spacing: 8) {
                        Text(dialogue.speaker)
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
                .onAppear {
                    if !isLoaded {
                        loadStory()
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
                Text("Hikaye Yükleniyor...")
                    .foregroundColor(.white)
                    .onAppear {
                        if !isLoaded {
                            loadStory()
                        }
                    }
            }
        }
        .contentShape(Rectangle())
        .onTapGesture {
            if let dialogue = currentDialogue {
                if typewriter.isTyping {
                    typewriter.completeTypewriterEffect(with: dialogue.text)
                } else {
                    goToNextDialogue()
                }
            }
        }
    }
    
    private var currentDialogue: Dialogue? {
        currentStep?.dialogues[safe: currentDialogueIndex]
    }
    
    private func goToNextDialogue() {
        guard let storyData = storyData else { return }
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
        if currentSectionIndex < storyData.storySections.count - 1 {
            currentSectionIndex += 1
            currentStepIndex = 0
            currentDialogueIndex = 0
            return
        }
        
        // Hikaye bitti
        onStoryFinished?()
    }
    
    private func updateCurrentSection() {
        guard let storyData = storyData else { return }
        currentSection = storyData.storySections[safe: currentSectionIndex]
        updateCurrentStep()
    }
    
    private func updateCurrentStep() {
        guard let section = currentSection else { return }
        currentStep = section.steps[safe: currentStepIndex]
        updateCurrentDialogue()
    }
    
    private func updateCurrentDialogue() {
        if let dialogue = currentDialogue {
            typewriter.startTypewriterEffect(for: dialogue.text)
        }
    }
    
    private func loadStory() {
        guard let url = Bundle.main.url(forResource: "story", withExtension: "json"),
              let data = try? Data(contentsOf: url),
              let decoded = try? JSONDecoder().decode(StoryData.self, from: data) else {
            return
        }
        self.storyData = decoded
        
        // İlk section, step ve dialogue'u ayarla
        currentSectionIndex = 0
        currentStepIndex = 0
        currentDialogueIndex = 0
        
        updateCurrentSection()
        self.isLoaded = true
    }
}

// Güvenli dizi erişimi için extension
extension Collection {
    subscript(safe index: Index) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
} 