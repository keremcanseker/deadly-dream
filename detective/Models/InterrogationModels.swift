import Foundation

struct InterrogationData: Codable {
    let title: String
    let version: String
    let intro: InterrogationIntro?
    let storySections: [InterrogationSection]
}

struct InterrogationIntro: Codable {
    let background: String
    let audio: String?
    let text: String
    let textDuration: Int?
}

struct InterrogationSection: Codable, Identifiable {
    let id: String
    let title: String?
    let steps: [InterrogationStep]
}

struct InterrogationStep: Codable {
    let image: String?
    let dialogues: [InterrogationDialogue]
}

struct InterrogationDialogue: Codable {
    let speaker: String
    let text: String
    let emotion: String?
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