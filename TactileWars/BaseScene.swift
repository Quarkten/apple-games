import SpriteKit

class BaseScene: SKScene {
    private var defenses: [DefenseStructure] = []
    private var troops: [Troop] = []
    private var selectedDefense: DefenseType?

    override func didMove(to view: SKView) {
        // Create defense selection buttons
        let mineButton = SKLabelNode(fontNamed: "Chalkduster")
        mineButton.text = "Mine"
        mineButton.name = "select_mine"
        mineButton.position = CGPoint(x: 100, y: frame.maxY - 50)
        addChild(mineButton)

        let tankButton = SKLabelNode(fontNamed: "Chalkduster")
        tankButton.text = "Tank"
        tankButton.name = "select_tank"
        tankButton.position = CGPoint(x: 200, y: frame.maxY - 50)
        addChild(tankButton)

        let cannonButton = SKLabelNode(fontNamed: "Chalkduster")
        cannonButton.text = "Cannon"
        cannonButton.name = "select_cannon"
        cannonButton.position = CGPoint(x: 300, y: frame.maxY - 50)
        addChild(cannonButton)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        let nodesAtPoint = nodes(at: location)

        for node in nodesAtPoint {
            if let nodeName = node.name {
                if nodeName.starts(with: "select_") {
                    let defenseType = nodeName.replacingOccurrences(of: "select_", with: "")
                    switch defenseType {
                    case "mine":
                        selectedDefense = .mine
                    case "tank":
                        selectedDefense = .tank
                    case "cannon":
                        selectedDefense = .cannon
                    default:
                        break
                    }
                    return
                }
            }
        }

        if let defenseType = selectedDefense {
            placeDefense(type: defenseType, at: location)
            selectedDefense = nil
        }
    }

    override func update(_ currentTime: TimeInterval) {
        for defense in defenses {
            if let closestTroop = findClosestTroop(to: defense.position) {
                if closestTroop.parent != nil {
                    let damage = DamageCalculator.calculateDamage(attacker: defense, defender: closestTroop)
                    closestTroop.takeDamage(damage)
                }
            }
        }

        for troop in troops {
            if let closestDefense = findClosestDefense(to: troop.position) {
                if closestDefense.parent != nil {
                    if troop.position.distance(to: closestDefense.position) < troop.attackRange {
                        let damage = DamageCalculator.calculateDamage(attacker: troop, defender: closestDefense)
                        closestDefense.takeDamage(damage)
                    }
                }
            }
        }
        troops.removeAll { $0.parent == nil }
    }

    func findClosestTroop(to position: CGPoint) -> Troop? {
        guard !troops.isEmpty else { return nil }

        var closestTroop: Troop?
        var closestDistance: CGFloat = .greatestFiniteMagnitude

        for troop in troops {
            let distance = position.distance(to: troop.position)
            if distance < closestDistance {
                closestDistance = distance
                closestTroop = troop
            }
        }
        return closestTroop
    }

    func findClosestDefense(to position: CGPoint) -> DefenseStructure? {
        guard !defenses.isEmpty else { return nil }

        var closestDefense: DefenseStructure?
        var closestDistance: CGFloat = .greatestFiniteMagnitude

        for defense in defenses {
            let distance = position.distance(to: defense.position)
            if distance < closestDistance {
                closestDistance = distance
                closestDefense = defense
            }
        }
        return closestDefense
    }

    func placeDefense(type: DefenseType, at position: CGPoint) {
        let defense: DefenseStructure
        switch type {
        case .mine:
            defense = Mine(texture: nil, color: .red, size: CGSize(width: 40, height: 40))
        case .tank:
            defense = Tank(texture: nil, color: .gray, size: CGSize(width: 80, height: 80))
        case .cannon:
            defense = Cannon(texture: nil, color: .black, size: CGSize(width: 60, height: 60))
        }
        defense.position = position
        defenses.append(defense)
        addChild(defense)
    }
}
