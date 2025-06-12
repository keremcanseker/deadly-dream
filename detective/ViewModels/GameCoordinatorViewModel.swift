import Foundation

enum GamePhase {
    case intro
    case disclaimerIntro
    case story
    case interrogation
    case decision
    case ending
}

@MainActor
final class GameCoordinatorViewModel: ObservableObject {
    @Published var scenario: Scenario
    @Published var phase: GamePhase = .intro
    @Published var selectedCulpritId: String? = nil

    init(scenario: Scenario) {
        self.scenario = scenario
    }

    func goToNextPhase() {
        switch phase {
        case .intro:
            phase = .disclaimerIntro
        case .disclaimerIntro:
            phase = .story
        case .story:
            phase = .interrogation
        case .interrogation:
            phase = .decision
        case .decision:
            phase = .ending
        case .ending:
            break
        }
    }

    func selectCulprit(id: String) {
        selectedCulpritId = id
        phase = .ending
    }

    var isCorrect: Bool {
        return selectedCulpritId == scenario.ending?.trueCulpritId
    }
} 