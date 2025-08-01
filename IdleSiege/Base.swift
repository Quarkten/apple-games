import Foundation

class Base {
    // Properties
    var buildings: [Building] = []
    var troops: [Troop] = []

    // Methods
    func addBuilding(_ building: Building) {
        buildings.append(building)
    }

    func addTroop(_ troop: Troop) {
        troops.append(troop)
    }
}
