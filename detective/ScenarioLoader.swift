import Foundation

struct ScenarioLoader {
    enum ScenarioLoaderError: Error, LocalizedError {
        case fileNotFound
        case dataReadFailed
        case decodeFailed(Error)
        
        var errorDescription: String? {
            switch self {
            case .fileNotFound:
                return "Senaryo dosyası bulunamadı."
            case .dataReadFailed:
                return "Senaryo dosyası okunamadı."
            case .decodeFailed(let error):
                return "Senaryo çözümlenemedi: \(error.localizedDescription)"
            }
        }
    }
    
    static func loadScenario(from filename: String = "scenerio", bundle: Bundle = .main) throws -> Scenario {
        guard let url = bundle.url(forResource: filename, withExtension: "json") else {
            throw ScenarioLoaderError.fileNotFound
        }
        guard let data = try? Data(contentsOf: url) else {
            throw ScenarioLoaderError.dataReadFailed
        }
        do {
            let scenario = try JSONDecoder().decode(Scenario.self, from: data)
            return scenario
        } catch {
            throw ScenarioLoaderError.decodeFailed(error)
        }
    }
    
    static func loadScenarioAsync(from filename: String = "scenerio", bundle: Bundle = .main) async throws -> Scenario {
        return try loadScenario(from: filename, bundle: bundle)
    }
} 