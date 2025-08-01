import SpriteKit

class MultiplayerBattleScene: SKScene {
    private var armies: [String: ArmyManager] = [:]

    override func didMove(to view: SKView) {
        armies["myArmy"] = ArmyManager.shared
        // In a real game, you would get the opponent's army data from the server
        armies["opponentArmy"] = ArmyManager()

        MultiplayerManager.shared.receivedDataHandler = { [weak self] data in
            self?.handleReceivedData(data)
        }

        // Position the armies
        for (armyID, army) in armies {
            for (index, clone) in army.clones.enumerated() {
                if armyID == "myArmy" {
                    clone.position = CGPoint(x: 100, y: 100 + index * 50)
                } else {
                    clone.position = CGPoint(x: frame.maxX - 100, y: 100 + index * 50)
                }
                addChild(clone)
            }
        }
    }

    func handleReceivedData(_ data: Data) {
        do {
            let gameState = try JSONDecoder().decode(GameState.self, from: data)
            for (armyID, armyState) in gameState.armies {
                if let army = armies[armyID] {
                    // Update existing army
                    // ...
                } else {
                    // Create new army
                    // ...
                }
            }
        } catch {
            print("Error decoding game state: \(error)")
        }
    }

    func sendGameState() {
        var armyStates: [String: ArmyState] = [:]
        for (armyID, army) in armies {
            var cloneStates: [CloneState] = []
            for clone in army.clones {
                cloneStates.append(CloneState(position: clone.position, health: clone.health))
            }
            armyStates[armyID] = ArmyState(clones: cloneStates)
        }
        let gameState = GameState(armies: armyStates)
        let data = try! JSONEncoder().encode(gameState)
        MultiplayerManager.shared.send(data: data)
    }

    override func update(_ currentTime: TimeInterval) {
        // Combat logic...

        sendGameState()
    }
}
