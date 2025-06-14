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
    let steps: [DialogueStep]
} 