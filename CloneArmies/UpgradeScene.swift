import SpriteKit

class UpgradeScene: SKScene {
    override func didMove(to view: SKView) {
        // Create upgrade buttons
        let sniperButton = SKLabelNode(fontNamed: "Chalkduster")
        sniperButton.text = "Upgrade Sniper"
        sniperButton.name = "upgrade_sniper"
        sniperButton.position = CGPoint(x: frame.midX, y: frame.midY + 100)
        addChild(sniperButton)

        let jetpackButton = SKLabelNode(fontNamed: "Chalkduster")
        jetpackButton.text = "Upgrade Jetpack"
        jetpackButton.name = "upgrade_jetpack"
        jetpackButton.position = CGPoint(x: frame.midX, y: frame.midY)
        addChild(jetpackButton)

        let tankButton = SKLabelNode(fontNamed: "Chalkduster")
        tankButton.text = "Upgrade Tank"
        tankButton.name = "upgrade_tank"
        tankButton.position = CGPoint(x: frame.midX, y: frame.midY - 100)
        addChild(tankButton)

        let weaponButton = SKLabelNode(fontNamed: "Chalkduster")
        weaponButton.text = "Upgrade Weapon"
        weaponButton.name = "upgrade_weapon"
        weaponButton.position = CGPoint(x: frame.midX, y: frame.midY - 200)
        addChild(weaponButton)
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
        let cost = 100 // For now, all upgrades cost 100
        if GameManager.shared.spendResources(cost) {
            switch name {
            case "upgrade_sniper":
                UpgradeManager.shared.upgradeTroop(for: .sniper)
                print("Sniper upgraded!")
            case "upgrade_jetpack":
                UpgradeManager.shared.upgradeTroop(for: .jetpack)
                print("Jetpack upgraded!")
            case "upgrade_tank":
                UpgradeManager.shared.upgradeTroop(for: .tank)
                print("Tank upgraded!")
            case "upgrade_weapon":
                UpgradeManager.shared.upgradeWeapon()
                print("Weapon upgraded!")
            default:
                break
            }
        } else {
            print("Not enough resources!")
        }
    }
}
