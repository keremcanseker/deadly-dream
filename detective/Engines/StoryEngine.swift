import Foundation

@MainActor
final class StoryEngine: ObservableObject {
    private let storySections: [StorySection]
    
    @Published var sectionIndex: Int = 0
    @Published var stepIndex: Int = 0
    @Published var dialogueIndex: Int = 0

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
        guard let step = currentStep,
              dialogueIndex < step.dialogues.count else { return nil }
        return step.dialogues[dialogueIndex]
    }

    func advance() {
        guard let step = currentStep else { return }

        if dialogueIndex + 1 < step.dialogues.count {
            dialogueIndex += 1
        } else if stepIndex + 1 < currentSection?.steps.count ?? 0 {
            stepIndex += 1
            dialogueIndex = 0
        } else if sectionIndex + 1 < storySections.count {
            sectionIndex += 1
            stepIndex = 0
            dialogueIndex = 0
        } else {
            // Story completely finished
            sectionIndex = storySections.count
        }
    }
} 