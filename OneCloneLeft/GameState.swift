import Foundation
import CoreGraphics

struct PlayerState: Codable {
    let id: String
    let position: CGPoint
    let health: Int
    let weapon: WeaponState?
    let clones: [CloneState]
}

struct WeaponState: Codable {
    // Add properties for weapon state, e.g., ammo, type
}

struct CloneState: Codable {
    let position: CGPoint
    let health: Int
}

struct GameState: Codable {
    let players: [PlayerState]
}
