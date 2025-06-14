import SwiftUI

struct DialogBoxStyle: PrimitiveButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            configuration.label
                .font(.custom("Saira-Medium", size: 16))
                .foregroundColor(.white)
                .padding()
                .background(Color.black.opacity(0.6))
                .cornerRadius(16)
        }
        .padding()
    }
}

extension PrimitiveButtonStyle where Self == DialogBoxStyle {
    static var dialogBox: DialogBoxStyle { DialogBoxStyle() }
}

struct SpeakerNameLabelStyle: LabelStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.title
            .font(.custom("Saira-SemiBold", size: 18))
            .foregroundColor(.orange)
    }
}

extension LabelStyle where Self == SpeakerNameLabelStyle {
    static var speakerName: SpeakerNameLabelStyle { SpeakerNameLabelStyle() }
}
