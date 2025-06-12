import SwiftUI

struct GameRootView: View {
    @StateObject var coordinator: GameCoordinatorViewModel
    @State private var showSettings = false

    var body: some View {
        switch coordinator.phase {
        case .intro:
            IntroView(
                intro: coordinator.scenario.intro,
                onStart: { coordinator.goToNextPhase() },
                onSettings: { showSettings = true }
            )
            .sheet(isPresented: $showSettings) {
                SettingsView { showSettings = false }
            }
        case .disclaimerIntro:
            DisclaimerIntroView(
                introText: coordinator.scenario.intro?.text ?? "",
                onComplete: { coordinator.goToNextPhase() }
            )
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