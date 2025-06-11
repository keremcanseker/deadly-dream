import SwiftUI

struct InterrogationView: View {
    @ObservedObject var viewModel: InterrogationViewModel
    let onComplete: () -> Void

    var body: some View {
        ZStack {
            if let image = viewModel.currentSuspect?.image {
                Image(image)
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
            }

            VStack {
                Spacer()
                if let dialogue = viewModel.currentDialogue {
                    VStack(alignment: .leading, spacing: 8) {
                        Text(dialogue.speaker)
                            .font(.headline)
                            .foregroundColor(.yellow)
                        Text(dialogue.text)
                            .font(.body)
                            .foregroundColor(.white)
                    }
                    .padding()
                    .background(Color.black.opacity(0.7))
                    .cornerRadius(16)
                    .padding()
                }

                Button(action: {
                    if viewModel.isLast {
                        onComplete()
                    } else {
                        viewModel.goToNextSuspect()
                    }
                }) {
                    Text(viewModel.isLast ? "Devam Et" : "Sonraki Şüpheli")
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                }
                .padding(.bottom)
            }
        }
        .contentShape(Rectangle())
        .onTapGesture {
            viewModel.nextDialogue()
        }
    }
} 