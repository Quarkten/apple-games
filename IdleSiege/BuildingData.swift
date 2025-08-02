import Foundation

struct BuildingData {
    let type: BuildingType
    let name: String
    let baseCost: [ResourceType: Int]
    let baseResourceGenerationRate: [ResourceType: Int]
}

let buildingData: [BuildingType: BuildingData] = [
    .barracks: BuildingData(type: .barracks, name: "Barracks", baseCost: [.gold: 50, .wood: 25], baseResourceGenerationRate: [:]),
    .resourceGenerator: BuildingData(type: .resourceGenerator, name: "Resource Generator", baseCost: [.gold: 25], baseResourceGenerationRate: [.gold: 1]),
    .academy: BuildingData(type: .academy, name: "Academy", baseCost: [.gold: 150, .wood: 75, .stone: 50], baseResourceGenerationRate: [:]),
    .lumberMill: BuildingData(type: .lumberMill, name: "Lumber Mill", baseCost: [.gold: 50, .stone: 25], baseResourceGenerationRate: [.wood: 1]),
    .quarry: BuildingData(type: .quarry, name: "Quarry", baseCost: [.gold: 50, .wood: 25], baseResourceGenerationRate: [.stone: 1]),
    .crystalMine: BuildingData(type: .crystalMine, name: "Crystal Mine", baseCost: [.gold: 200, .wood: 100, .stone: 100], baseResourceGenerationRate: [.crystal: 1])
]
