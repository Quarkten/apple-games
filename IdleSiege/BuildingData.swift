import Foundation

struct BuildingData {
    let type: BuildingType
    let name: String
    let baseCost: Int
    let baseResourceGenerationRate: Int
}

let buildingData: [BuildingType: BuildingData] = [
    .barracks: BuildingData(type: .barracks, name: "Barracks", baseCost: 100, baseResourceGenerationRate: 0),
    .resourceGenerator: BuildingData(type: .resourceGenerator, name: "Resource Generator", baseCost: 50, baseResourceGenerationRate: 1),
    .academy: BuildingData(type: .academy, name: "Academy", baseCost: 200, baseResourceGenerationRate: 0)
]
