import SwiftUI

struct InterrogationView: View {
    let onInterrogationFinished: (() -> Void)?
    
    init(onInterrogationFinished: (() -> Void)? = nil) {
        self.onInterrogationFinished = onInterrogationFinished
    }
    
    var body: some View {
        DialogueSequenceView(steps: loadSteps(fromResource: "interregation"), onFinished: onInterrogationFinished)
    }
}

