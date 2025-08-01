import SpriteKit

class UpgradeScene: SKScene {
    override func didMove(to view: SKView) {
        // Create upgrade buttons
        let upgradeWeaponButton = SKLabelNode(fontNamed: "Chalkduster")
        upgradeWeaponButton.text = "Upgrade Weapon"
        upgradeWeaponButton.name = "upgrade_weapon"
        upgradeWeaponButton.position = CGPoint(x: frame.midX, y: frame.midY + 50)
        addChild(upgradeWeaponButton)

        let upgradeArmyButton = SKLabelNode(fontNamed: "Chalkduster")
        upgradeArmyButton.text = "Upgrade Army"
        upgradeArmyButton.name = "upgrade_army"
        upgradeArmyButton.position = CGPoint(x: frame.midX, y: frame.midY - 50)
        addChild(upgradeArmyButton)

        let upgradeHealthButton = SKLabelNode(fontNamed: "Chalkduster")
        upgradeHealthButton.text = "Upgrade Health"
        upgradeHealthButton.name = "upgrade_health"
        upgradeHealthButton.position = CGPoint(x: frame.midX, y: frame.midY - 150)
        addChild(upgradeHealthButton)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        let nodesAtPoint = nodes(at: location)

        for node in nodesAtPoint {
            if let nodeName = node.name {
                handleButtonPress(name: nodeName)
            }
        }
    }

    func handleButtonPress(name: String) {
        switch name {
        case "upgrade_weapon":
            UpgradeSystem.shared.upgradeWeapon()
        case "upgrade_army":
            UpgradeSystem.shared.upgradeArmy()
        case "upgrade_health":
            UpgradeSystem.shared.upgradeHealth()
        default:
            break
        }
    }
}
