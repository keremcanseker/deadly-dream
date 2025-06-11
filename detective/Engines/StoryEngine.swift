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
        guard let step = currentStep else { 
            print("ERROR: currentStep nil!")
            return 
        }

        print("BEFORE: sectionIndex=\(sectionIndex), stepIndex=\(stepIndex), dialogueIndex=\(dialogueIndex)")
        print("step.dialogues.count = \(step.dialogues.count)")

        if dialogueIndex + 1 < step.dialogues.count {
            dialogueIndex += 1
            print("DIYALOG İLERLETİLDİ: dialogueIndex=\(dialogueIndex)")
        } else {
            if sectionIndex + 1 < storySections.count {
                sectionIndex += 1
                stepIndex = 0
                dialogueIndex = 0
                print("YENİ SECTION'A GEÇİLDİ: sectionIndex=\(sectionIndex)")
            } else {
                sectionIndex = storySections.count
                print("HİKAYE BİTTİ")
            }
        }
        
        print("AFTER: sectionIndex=\(sectionIndex), stepIndex=\(stepIndex), dialogueIndex=\(dialogueIndex)")
    }
} 