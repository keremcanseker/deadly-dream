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

    func next() {
        engine.advance()
        // Manuel olarak UI güncellemesini tetikle
        objectWillChange.send()
    }

    var isFinished: Bool {
        engine.isFinished
    }
} 