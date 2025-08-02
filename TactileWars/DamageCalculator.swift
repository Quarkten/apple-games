import Foundation

class DamageCalculator {
    static func calculateDamage(attacker: Troop, defender: DefenseStructure) -> Int {
        var damage = Double(attacker.attackPower)
        switch attacker.type {
        case .infantry:
            if defender.type == .cannon { damage *= 1.5 }
        case .ranged:
            if defender.type == .tank { damage *= 1.5 }
        case .cavalry:
            if defender.type == .mine { damage *= 2.0 }
        }
        return Int(damage)
    }

    static func calculateDamage(attacker: DefenseStructure, defender: Troop) -> Int {
        var damage = Double(attacker.damage)
        switch attacker.type {
        case .cannon:
            if defender.type == .infantry { damage *= 1.5 }
        case .tank:
            if defender.type == .ranged { damage *= 1.5 }
        case .mine:
            if defender.type == .cavalry { damage *= 2.0 }
        }
        return Int(damage)
    }
}
