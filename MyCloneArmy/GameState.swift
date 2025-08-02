import Foundation
import CoreGraphics

struct ArmyState: Codable {
    let clones: [CloneState]
}

struct CloneState: Codable {
    let position: CGPoint
    let health: Int
}

struct GameState: Codable {
    let armies: [String: ArmyState]
}
