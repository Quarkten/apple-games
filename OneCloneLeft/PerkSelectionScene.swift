import SpriteKit

class PerkSelectionScene: SKScene {
    var availablePerks: [Perk] = []
    var player: Player!

    override func didMove(to view: SKView) {
        // In a real game, you would get the available perks from a manager
        let allPerks = [
            Perk(name: "Extra Health", description: "Increases health by 20%", effect: { player in
                player.health += Int(Double(player.health) * 0.2)
            }),
            Perk(name: "Faster Reload", description: "Increases reload speed by 30%", effect: { player in
                player.weapon?.reloadTime *= 0.7
            }),
            Perk(name: "More Damage", description: "Increases damage by 25%", effect: { player in
                player.weapon?.damage = Int(Double(player.weapon?.damage ?? 0) * 1.25)
            }),
            Perk(name: "Increased Fire Rate", description: "Increases fire rate by 20%", effect: { player in
                player.weapon?.fireRate *= 0.8
            }),
            Perk(name: "Extra Clone", description: "Allows you to have one more clone", effect: { player in
                // player.maxClones += 1
            }),
            Perk(name: "Increased Speed", description: "Increases movement speed by 15%", effect: { player in
                // player.movementSpeed *= 1.15
            }),
            Perk(name: "Loot Goblin", description: "Increases the chance to find more loot", effect: { player in
                // player.lootChance *= 1.25
            })
        ]

        availablePerks = Array(allPerks.shuffled().prefix(3))

        // Create perk selection buttons
        for (index, perk) in availablePerks.enumerated() {
            let perkButton = SKLabelNode(fontNamed: "Chalkduster")
            perkButton.text = perk.name
            perkButton.name = "perk_\(index)"
            perkButton.position = CGPoint(x: frame.midX, y: frame.maxY - 100 - CGFloat(index * 100))
            addChild(perkButton)
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        let nodesAtPoint = nodes(at: location)

        for node in nodesAtPoint {
            if let nodeName = node.name, nodeName.starts(with: "perk_") {
                let perkIndex = Int(nodeName.replacingOccurrences(of: "perk_", with: ""))!
                let selectedPerk = availablePerks[perkIndex]
                player.addPerk(selectedPerk)
                // Go back to the game scene
                // view?.presentScene(GameScene(size: self.size))
            }
        }
    }
}
