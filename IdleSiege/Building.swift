import Foundation

enum BuildingType {
    case barracks
    case resourceGenerator
    case academy
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
        if let data = buildingData[type] {
            self.cost = data.baseCost * level
            self.resourceGenerationRate = data.baseResourceGenerationRate * level
        } else {
            self.cost = 0
            self.resourceGenerationRate = 0
        }
    }

    // Methods
    func upgrade() {
        level += 1
        if let data = buildingData[type] {
            self.cost = data.baseCost * level
            self.resourceGenerationRate = data.baseResourceGenerationRate * level
        }
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

// Academy Building
class Academy: Building {
    init() {
        super.init(type: .academy)
    }
}
