import Foundation

@MainActor
final class StoryViewModel: ObservableObject {
    @Published private(set) var engine: StoryEngine

    init(sections: [StorySection]) {
        self.engine = StoryEngine(storySections: sections)
    }

    var currentImage: String? {
        engine.currentStep?.image
    }

    var currentDialogue: DialogueLine? {
        engine.currentDialogue
    }
    
    var hasChoices: Bool {
        engine.hasChoices
    }
    
    var playerChoices: [PlayerChoice] {
        engine.playerChoices
    }
    
    var waitingForChoiceSelection: Bool {
        engine.waitingForChoiceSelection
    }
    
    var showingChoiceResponse: Bool {
        engine.selectedChoiceResponse != nil
    }
    
    func selectChoice(_ choice: PlayerChoice) {
        engine.selectChoice(choice)
        // Trigger UI update
        objectWillChange.send()
    }

    func next() {
        engine.advance()
        objectWillChange.send()
    }

    var isFinished: Bool {
        engine.isFinished
    }
}
