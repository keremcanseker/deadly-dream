import SwiftUI

struct StoryView: View {
    let onStoryFinished: (() -> Void)?
    
    init(onStoryFinished: (() -> Void)? = nil) {
        self.onStoryFinished = onStoryFinished
    }
    
    var body: some View {
        DialogueSequenceView(steps: loadSteps(fromResource: "story"), onFinished: onStoryFinished)
    }
}

