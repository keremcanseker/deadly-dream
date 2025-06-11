import SwiftUI

struct StoryView: View {
    @ObservedObject var viewModel: StoryViewModel
    let onStoryFinished: () -> Void

    var body: some View {
        ZStack {
            if let image = viewModel.currentImage {
                Image(image)
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
            }

            if let dialogue = viewModel.currentDialogue {
                VStack {
                    Spacer()
                    VStack(alignment: .leading, spacing: 8) {
                        Text(dialogue.speaker)
                            .font(.headline)
                            .foregroundColor(.orange)
                        Text(dialogue.text)
                            .font(.body)
                            .foregroundColor(.white)
                    }
                    .padding()
                    .background(Color.black.opacity(0.6))
                    .cornerRadius(16)
                    .padding()
                }
            }
        }
        .contentShape(Rectangle())
        .onTapGesture {
            viewModel.next()
            if viewModel.isFinished {
                onStoryFinished()
            }
        }
    }
}

// KULLANIM ORNEGI
// StoryView(viewModel: StoryViewModel(sections: scenario.storySections ?? [])) {
//     // proceed to InterrogationView
// }
