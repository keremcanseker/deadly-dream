import Foundation

@MainActor
final class StoryEngine: ObservableObject {
    private let storySections: [StorySection]
    
    @Published var sectionIndex: Int = 0
    @Published var stepIndex: Int = 0
    @Published var dialogueIndex: Int = 0
    @Published var selectedChoiceResponse: ChoiceResponse? = nil
    @Published var waitingForChoiceSelection: Bool = false

    var isFinished: Bool {
        return sectionIndex >= storySections.count
    }

    init(storySections: [StorySection]) {
        self.storySections = storySections
    }

    var currentSection: StorySection? {
        guard sectionIndex < storySections.count else { return nil }
        return storySections[sectionIndex]
    }

    var currentStep: StoryStep? {
        guard let section = currentSection,
              stepIndex < section.steps.count else { return nil }
        return section.steps[stepIndex]
    }

    var currentDialogue: DialogueLine? {
        // If we have a selected choice response, show that instead
        if let response = selectedChoiceResponse {
            return DialogueLine(
                speaker: response.speaker,
                text: response.text,
                emotion: response.emotion,
                action: nil,
                playerChoices: nil
            )
        }
        
        guard let step = currentStep,
              dialogueIndex < step.dialogues.count else { return nil }
        return step.dialogues[dialogueIndex]
    }
    
    var hasChoices: Bool {
        guard let dialogue = currentDialogue,
              selectedChoiceResponse == nil else { return false }
        return dialogue.playerChoices?.isEmpty == false
    }
    
    var playerChoices: [PlayerChoice] {
        return currentDialogue?.playerChoices ?? []
    }
    
    func selectChoice(_ choice: PlayerChoice) {
        selectedChoiceResponse = choice.response
        waitingForChoiceSelection = false
    }
    
    func advance() {
        // If we're showing a choice response, clear it and move to next dialogue
        if selectedChoiceResponse != nil {
            selectedChoiceResponse = nil
            normalAdvance()
            return
        }
        
        // If current dialogue has choices, don't advance - wait for choice selection
        if hasChoices {
            waitingForChoiceSelection = true
            return
        }
        
        // Normal advancement
        normalAdvance()
    }
    
    private func normalAdvance() {
        guard let step = currentStep else { return }

        if dialogueIndex + 1 < step.dialogues.count {
            dialogueIndex += 1
        } else {
            if sectionIndex + 1 < storySections.count {
                sectionIndex += 1
                stepIndex = 0
                dialogueIndex = 0
            } else {
                sectionIndex = storySections.count
            }
        }
        
        waitingForChoiceSelection = false
    }
}
