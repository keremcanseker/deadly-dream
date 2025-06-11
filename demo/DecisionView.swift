import SwiftUI

struct DecisionView: View {
    @ObservedObject var viewModel: DecisionViewModel
    let onCulpritSelected: (String) -> Void

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            VStack {
                Text("Katil Kim?")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .padding()

                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 20) {
                        ForEach(viewModel.suspects) { suspect in
                            VStack {
                                if let image = suspect.image {
                                    Image(image)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 200, height: 200)
                                        .clipShape(RoundedRectangle(cornerRadius: 20))
                                }
                                Text(suspect.name)
                                    .foregroundColor(.white)
                                    .padding(.top, 8)
                                Button("Seç") {
                                    onCulpritSelected(suspect.id)
                                }
                                .padding(.top, 4)
                                .buttonStyle(.borderedProminent)
                            }
                        }
                    }
                    .padding()
                }
            }
        }
    }
}
