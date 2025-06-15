import SwiftUI

struct GameButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.custom("Saira-SemiBold", size: 18))
            .foregroundColor(.white)
            .padding(.horizontal, 24)
            .padding(.vertical, 16)
            .frame(width: 180)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.black.opacity(0.6))
            )
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.white.opacity(0.3), lineWidth: 1)
            )
            .shadow(color: Color.blue.opacity(0.4), radius: 8)
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .animation(.easeInOut(duration: 0.1), value: configuration.isPressed)
    }
}

extension ButtonStyle where Self == GameButtonStyle {
    static var gameButton: GameButtonStyle { GameButtonStyle() }
}

struct NotesButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.custom("Saira-SemiBold", size: 14))
            .foregroundColor(.white)
            .frame(width: 50, height: 50)
            .background(
                Circle()
                    .fill(Color.black.opacity(0.7))
            )
            .overlay(
                Circle()
                    .stroke(Color.orange.opacity(0.6), lineWidth: 2)
            )
            .shadow(color: Color.orange.opacity(0.3), radius: 6)
            .scaleEffect(configuration.isPressed ? 0.9 : 1.0)
            .animation(.easeInOut(duration: 0.1), value: configuration.isPressed)
    }
}

extension ButtonStyle where Self == NotesButtonStyle {
    static var notesButton: NotesButtonStyle { NotesButtonStyle() }
}
