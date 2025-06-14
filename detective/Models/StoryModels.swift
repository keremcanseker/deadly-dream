import Foundation

struct StoryData: Codable {
    let storySections: [StorySection]
}

struct StorySection: Codable, Identifiable {
    let id: String
    let title: String?
    let steps: [StoryStep]
}

struct StoryStep: Codable {
    let image: String?
    let dialogues: [Dialogue]
}

struct Dialogue: Codable {
    let speaker: String
    let text: String
    let emotion: String?
    let action: String?
} 