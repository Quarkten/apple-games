import Foundation

struct Perk {
    let name: String
    let description: String
    let effect: (Player) -> Void
}
