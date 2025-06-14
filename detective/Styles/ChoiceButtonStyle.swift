import SwiftUI

struct ChoiceButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.custom("Saira-Medium", size: 15))
            .foregroundColor(.white)
            .multilineTextAlignment(.leading)
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color.black.opacity(configuration.isPressed ? 0.8 : 0.6))
            .cornerRadius(16)
    }
}

extension ButtonStyle where Self == ChoiceButtonStyle {
    static var choiceButton: ChoiceButtonStyle { ChoiceButtonStyle() }
} 