import Foundation

struct StoryData: Codable {
    let storySections: [StorySection]
}

struct StorySection: Codable, Identifiable {
    let id: String
    let title: String?
    let steps: [DialogueStep]
} 