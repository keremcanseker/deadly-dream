import Foundation

@MainActor
final class InterrogationViewModel: ObservableObject {
    @Published private(set) var engine: InterrogationEngine

    init(suspects: [Suspect]) {
        self.engine = InterrogationEngine(suspects: suspects)
    }

    var currentSuspect: Suspect? {
        engine.currentSuspect
    }

    var currentDialogue: DialogueLine? {
        engine.currentDialogue
    }

    var currentEvidence: Evidence? {
        engine.currentEvidence
    }

    func nextDialogue() {
        engine.advanceDialogue()
    }

    func goToNextSuspect() {
        engine.nextSuspect()
    }

    var isLast: Bool {
        engine.isLastSuspect
    }
}
