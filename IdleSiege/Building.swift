import Foundation

enum BuildingType {
    case barracks
    case resourceGenerator
}

// Base Building Class
class Building {
    // Properties
    var level: Int = 1
    var isUpgrading: Bool = false
    var type: BuildingType
    var cost: Int
    var resourceGenerationRate: Int

    // Initializer
    init(type: BuildingType) {
        self.type = type
        self.cost = 100 * level
        self.resourceGenerationRate = 1 * level
    }

    // Methods
    func upgrade() {
        level += 1
        cost = 100 * level
        resourceGenerationRate = 1 * level
    }
}

// Barracks Building
class Barracks: Building {
    init() {
        super.init(type: .barracks)
    }
}

// Resource Generator Building
class ResourceGenerator: Building {
    init() {
        super.init(type: .resourceGenerator)
    }
}
