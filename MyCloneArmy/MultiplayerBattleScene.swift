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

    func startBattle() {
        // Simple combat logic: the army with more clones wins
        if myArmy.clones.count > opponentArmy.clones.count {
            print("You win!")
        } else if myArmy.clones.count < opponentArmy.clones.count {
            print("You lose!")
        } else {
            print("It's a draw!")
        }
    }
}
