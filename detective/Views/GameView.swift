import SwiftUI

enum GameStep {
    case intro, disclaimer, story, interrogation, summary, decision, ending
}

class GameCoordinatorViewModel: ObservableObject {
    @Published var currentStep: GameStep = .intro

    func goToNext() {
        switch currentStep {
        case .intro:
            currentStep = .disclaimer
        case .disclaimer:
            currentStep = .story
        case .story:
            currentStep = .interrogation
        case .interrogation:
            currentStep = .summary
        case .summary:
            currentStep = .decision
        case .decision:
            currentStep = .ending
        case .ending:
            currentStep = .intro
        }
    }
}

struct GameView: View {
    @StateObject var coordinator = GameCoordinatorViewModel()
    @State private var showSettings = false

    var body: some View {
        switch coordinator.currentStep {
        case .intro:
            IntroView(
                onStartGame: coordinator.goToNext,
                onShowSettings: { showSettings.toggle() }
            )
        case .disclaimer:
            DisclaimerIntroView(

                onComplete: coordinator.goToNext
            )
        case .story:
            StoryView(
              onStoryFinished: coordinator.goToNext
            )
        case .interrogation:
            InterrogationView(
                onInterrogationFinished: coordinator.goToNext
            )
        default:
            EmptyView()
        }
    }
} 
