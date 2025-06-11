import Foundation

@MainActor
final class DecisionViewModel: ObservableObject {
    let suspects: [Suspect]

    init(suspects: [Suspect]) {
        self.suspects = suspects
    }
} 