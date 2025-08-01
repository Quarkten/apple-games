import Foundation

class PerkSystem {
    // Properties
    static let shared = PerkSystem()
    private var availablePerks: [String] = ["Extra Health", "Faster Reload", "More Damage"]
    var unlockedPerks: [String] = []

    // Private init for singleton
    private init() {}

    // Methods
    func unlockRandomPerk() {
        if let perk = availablePerks.randomElement() {
            unlockedPerks.append(perk)
        }
    }
}
