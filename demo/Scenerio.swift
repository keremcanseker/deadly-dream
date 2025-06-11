import Foundation

// MARK: - Root Scenario Model

struct Scenario: Codable {
    let title: String?
    let version: String?
    let intro: IntroSection?
    let storySections: [StorySection]?
    let suspects: [Suspect]?
    let ending: EndingSection?
}

// MARK: - Intro Section (Opening Screen)

struct IntroSection: Codable {
    let background: String?
    let audio: String?
    let text: String?
}

// MARK: - Story Section (Comic-Style Narrative)

struct StorySection: Codable {
    let id: String
    let title: String?
    let steps: [StoryStep]
}

struct StoryStep: Codable {
    let image: String
    let audio: String?
    let dialogues: [DialogueLine]
}

struct DialogueLine: Codable {
    let speaker: String
    let text: String
}

// MARK: - Suspect + Interrogation Data

struct Suspect: Codable, Identifiable {
    let id: String
    let name: String
    let image: String?
    let summary: String?
    let interrogation: Interrogation
}

struct Interrogation: Codable {
    let dialogues: [DialogueLine]
    let evidence: [Evidence]
}

// MARK: - Evidence Types

enum EvidenceType: String, Codable {
    case audio
    case note
}

struct Evidence: Codable {
    let type: EvidenceType
    let label: String
    let file: String?  // used if type == .audio
    let text: String?  // used if type == .note
}

// MARK: - Ending Section (After Player’s Decision)

struct EndingSection: Codable {
    let trueCulpritId: String
    let narration: String
    let image: String?
    let audio: String?
}
