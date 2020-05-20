import Foundation

enum RuntimeError: LocalizedError {
    case invalidData

    var errorDescription: String? {
        switch self {
        case .invalidData: return "The input data is invalid"
        }
    }
}
