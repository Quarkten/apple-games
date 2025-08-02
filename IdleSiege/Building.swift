import Foundation

enum BuildingType {
    case barracks
    case resourceGenerator
    case academy
    case lumberMill
    case quarry
}

// Base Building Class
class Building {
    // Properties
    var level: Int = 1
    var isUpgrading: Bool = false
    var type: BuildingType
    var cost: [ResourceType: Int]
    var resourceGenerationRate: [ResourceType: Int]

    // Initializer
    init(type: BuildingType) {
        self.type = type
        self.cost = [:]
        self.resourceGenerationRate = [:]
        if let data = buildingData[type] {
            for (resource, amount) in data.baseCost {
                self.cost[resource] = amount * level
            }
            for (resource, amount) in data.baseResourceGenerationRate {
                self.resourceGenerationRate[resource] = amount * level
            }
        }
    }

    // Methods
    func build() {
        let scaleUp = SKAction.scale(to: 1.2, duration: 0.2)
        let scaleDown = SKAction.scale(to: 1.0, duration: 0.2)
        self.run(SKAction.sequence([scaleUp, scaleDown]))
    }

    func upgrade() {
        level += 1
        if let data = buildingData[type] {
            for (resource, amount) in data.baseCost {
                self.cost[resource] = amount * level
            }
            for (resource, amount) in data.baseResourceGenerationRate {
                self.resourceGenerationRate[resource] = amount * level
            }
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

// Lumber Mill Building
class LumberMill: Building {
    init() {
        super.init(type: .lumberMill)
    }
}

// Quarry Building
class Quarry: Building {
    init() {
        super.init(type: .quarry)
    }
}
