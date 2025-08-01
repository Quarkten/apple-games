import Foundation

class DamageCalculator {
    static func calculateDamage(attacker: Troop, defender: DefenseStructure) -> Int {
        var damage = attacker.attackPower
        // Add logic for troop vs defense type advantages/disadvantages
        return damage
    }

    static func calculateDamage(attacker: DefenseStructure, defender: Troop) -> Int {
        var damage = attacker.damage
        // Add logic for defense vs troop type advantages/disadvantages
        return damage
    }
}
