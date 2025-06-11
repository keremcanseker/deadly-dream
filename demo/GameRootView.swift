import SwiftUI

struct GameRootView: View {
    @StateObject var coordinator: GameCoordinatorViewModel

    var body: some View {
        switch coordinator.phase {
        case .intro:
            IntroView(onStart: coordinator.goToNextPhase)
        case .story:
            if let sections = coordinator.scenario.storySections {
                StoryView(viewModel: StoryViewModel(sections: sections)) {
                    coordinator.goToNextPhase()
                }
            }
        case .interrogation:
            if let suspects = coordinator.scenario.suspects {
                InterrogationView(viewModel: InterrogationViewModel(suspects: suspects)) {
                    coordinator.goToNextPhase()
                }
            }
        case .decision:
            if let suspects = coordinator.scenario.suspects {
                DecisionView(viewModel: DecisionViewModel(suspects: suspects)) { selectedId in
                    coordinator.selectCulprit(id: selectedId)
                }
            }
        case .ending:
            if let ending = coordinator.scenario.ending {
                EndingView(ending: ending, isCorrect: coordinator.isCorrect)
            }
        }
    }
}
