import SpriteKit

class MultiplayerBattleScene: SKScene {
    private var myArmy: ArmyManager!
    private var opponentArmy: ArmyManager!

    override func didMove(to view: SKView) {
        myArmy = ArmyManager.shared
        opponentArmy = ArmyManager() // In a real game, this would be populated with the opponent's data

        // Position the armies
        for (index, clone) in myArmy.clones.enumerated() {
            clone.position = CGPoint(x: 100, y: 100 + index * 50)
            addChild(clone)
        }

        for (index, clone) in opponentArmy.clones.enumerated() {
            clone.position = CGPoint(x: frame.maxX - 100, y: 100 + index * 50)
            addChild(clone)
        }

        // Start the battle
        startBattle()
    }

    override func update(_ currentTime: TimeInterval) {
        // Make clones attack each other
        for myClone in myArmy.clones {
            if let opponentClone = opponentArmy.clones.first {
                myClone.attack(opponentClone)
            }
        }

        for opponentClone in opponentArmy.clones {
            if let myClone = myArmy.clones.first {
                opponentClone.attack(myClone)
            }
        }

        // Remove dead clones
        myArmy.clones.removeAll { $0.health <= 0 }
        opponentArmy.clones.removeAll { $0.health <= 0 }

        // Check for battle end
        if myArmy.clones.isEmpty {
            print("You lose!")
            // End the battle
        } else if opponentArmy.clones.isEmpty {
            print("You win!")
            // End the battle
        }
    }

    func startBattle() {
        // The battle will now be handled in the update method
    }
}
