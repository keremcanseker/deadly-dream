import Foundation

struct DialogueStep: Codable {
    let image: String?
    let dialogues: [Dialogue]
}

struct Dialogue: Codable {
    let speaker: String
    let text: String
    let emotion: String?
    let action: String?
    let playerChoices: [PlayerChoice]?
}

struct PlayerChoice: Codable {
    let text: String
    let response: ChoiceResponse
}

struct ChoiceResponse: Codable {
    let speaker: String
    let text: String
    let emotion: String?
} 