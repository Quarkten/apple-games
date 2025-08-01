import Foundation

// Base Building Class
class Building {
    // Properties
    var level: Int = 1
    var isUpgrading: Bool = false

    // Methods
    func upgrade() {
        level += 1
    }
}

// Barracks Building
class Barracks: Building {
    // Barracks-specific properties and methods
}

// Resource Generator Building
class ResourceGenerator: Building {
    // Resource-specific properties and methods
}
