import SpriteKit

class ArmyManagementScene: SKScene {
    override func didMove(to view: SKView) {
        // Create title label
        let titleLabel = SKLabelNode(fontNamed: "Chalkduster")
        titleLabel.text = "My Army"
        titleLabel.fontSize = 64
        titleLabel.position = CGPoint(x: frame.midX, y: frame.midY + 200)
        addChild(titleLabel)

        // In a real game, you would get the army data from the ArmyManager
        let armySize = ArmyManager.shared.clones.count
        let armySizeLabel = SKLabelNode(fontNamed: "Chalkduster")
        armySizeLabel.text = "Army Size: \(armySize)"
        armySizeLabel.fontSize = 32
        armySizeLabel.position = CGPoint(x: frame.midX, y: frame.midY + 100)
        addChild(armySizeLabel)

        // Create upgrade buttons
        let upgradeWeaponButton = SKLabelNode(fontNamed: "Chalkduster")
        upgradeWeaponButton.text = "Upgrade Weapon"
        upgradeWeaponButton.name = "upgrade_weapon"
        upgradeWeaponButton.position = CGPoint(x: frame.midX, y: frame.midY)
        addChild(upgradeWeaponButton)

        let upgradeArmyButton = SKLabelNode(fontNamed: "Chalkduster")
        upgradeArmyButton.text = "Upgrade Army"
        upgradeArmyButton.name = "upgrade_army"
        upgradeArmyButton.position = CGPoint(x: frame.midX, y: frame.midY - 100)
        addChild(upgradeArmyButton)
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
        default:
            break
        }
    }
}
