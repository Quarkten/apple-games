import Foundation

struct BuildingData {
    let type: BuildingType
    let name: String
    let baseCost: [ResourceType: Int]
    let baseResourceGenerationRate: [ResourceType: Int]
}

let buildingData: [BuildingType: BuildingData] = [
    .barracks: BuildingData(type: .barracks, name: "Barracks", baseCost: [.gold: 100, .wood: 50], baseResourceGenerationRate: [:]),
    .resourceGenerator: BuildingData(type: .resourceGenerator, name: "Resource Generator", baseCost: [.gold: 50], baseResourceGenerationRate: [.gold: 1]),
    .academy: BuildingData(type: .academy, name: "Academy", baseCost: [.gold: 200, .wood: 100, .stone: 50], baseResourceGenerationRate: [:]),
    .lumberMill: BuildingData(type: .lumberMill, name: "Lumber Mill", baseCost: [.gold: 75, .stone: 25], baseResourceGenerationRate: [.wood: 2]),
    .quarry: BuildingData(type: .quarry, name: "Quarry", baseCost: [.gold: 75, .wood: 25], baseResourceGenerationRate: [.stone: 2])
]
