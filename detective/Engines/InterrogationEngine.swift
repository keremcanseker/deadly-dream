import Foundation

@MainActor
final class InterrogationEngine: ObservableObject {
    let suspects: [Suspect]

    @Published var currentIndex: Int = 0
    @Published var dialogueIndex: Int = 0
    @Published var evidenceIndex: Int = 0

    init(suspects: [Suspect]) {
        self.suspects = suspects
    }

    var currentSuspect: Suspect? {
        guard currentIndex < suspects.count else { return nil }
        return suspects[currentIndex]
    }

    var currentDialogue: DialogueLine? {
        guard let interrogation = currentSuspect?.interrogation,
              dialogueIndex < interrogation.dialogues.count else { return nil }
        return interrogation.dialogues[dialogueIndex]
    }

    var currentEvidence: Evidence? {
        guard let interrogation = currentSuspect?.interrogation,
              evidenceIndex < interrogation.evidence.count else { return nil }
        return interrogation.evidence[evidenceIndex]
    }

    func advanceDialogue() {
        guard let interrogation = currentSuspect?.interrogation else { return }

        if dialogueIndex + 1 < interrogation.dialogues.count {
            dialogueIndex += 1
        } else {
            dialogueIndex = 0
        }
    }

    func nextSuspect() {
        if currentIndex + 1 < suspects.count {
            currentIndex += 1
            dialogueIndex = 0
            evidenceIndex = 0
        }
    }

    var isLastSuspect: Bool {
        return currentIndex >= suspects.count - 1
    }
} 