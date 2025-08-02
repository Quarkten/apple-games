import SpriteKit

class MultiplayerBattleScene: SKScene {
    private var armies: [String: ArmyManager] = [:]
    private var mission: Mission?

    convenience init(mission: Mission) {
        self.init(size: CGSize(width: 1024, height: 768)) // Or your desired size
        self.mission = mission
    }

    override func didMove(to view: SKView) {
        armies.removeAll()
        // Add background
        let background = SKSpriteNode(imageNamed: "background.png")
        background.position = CGPoint(x: frame.midX, y: frame.midY)
        background.zPosition = -1
        addChild(background)

        // Add obstacles
        for _ in 0..<5 {
            let obstacle = SKSpriteNode(color: .darkGray, size: CGSize(width: 50, height: 50))
            let randomX = CGFloat.random(in: self.frame.minX...self.frame.maxX)
            let randomY = CGFloat.random(in: self.frame.minY...self.frame.maxY)
            obstacle.position = CGPoint(x: randomX, y: randomY)
            addChild(obstacle)
        }

        armies["myArmy"] = ArmyManager.shared

        if let mission = mission {
            // Setup AI opponent
            let opponentArmy = ArmyManager()
            for cloneState in mission.aiOpponent.army.clones {
                let clone = PlayerClone(texture: nil, color: .red, size: CGSize(width: 50, height: 50))
                clone.position = cloneState.position
                clone.health = cloneState.health
                opponentArmy.addClone(clone)
            }
            armies["opponentArmy"] = opponentArmy
        } else {
            // Setup multiplayer opponent
            armies["opponentArmy"] = ArmyManager()
            MultiplayerManager.shared.receivedDataHandler = { [weak self] data in
                self?.handleReceivedData(data)
            }
            MultiplayerManager.shared.connectionStateChangedHandler = { [weak self] peerID, state in
                if state == .notConnected {
                    // In a real game, you would need a more robust way to identify the player's army
                    self?.armies.removeValue(forKey: "opponentArmy")
                }
            }
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
        for (armyID, army) in armies {
            for clone in army.clones {
                if let opponentArmy = armies.values.first(where: { $0 !== army }),
                   let opponentClone = findClosestClone(to: clone.position, in: opponentArmy) {

                    let distance = clone.position.distance(to: opponentClone.position)
                    if distance < 100 {
                        clone.attack()
                        let damage = Int.random(in: 5...15)
                        opponentClone.takeDamage(damage)
                    } else {
                        clone.walk()
                        let direction = (opponentClone.position - clone.position).normalized()
                        clone.position += direction * 50 * 0.016
                    }
                }
            }
        }

        // Remove dead clones
        for army in armies.values {
            army.clones.removeAll { $0.health <= 0 }
        }

        sendGameState()
    }

    func findClosestClone(to position: CGPoint, in army: ArmyManager) -> PlayerClone? {
        guard !army.clones.isEmpty else { return nil }
        var closestClone: PlayerClone?
        var closestDistance: CGFloat = .greatestFiniteMagnitude
        for clone in army.clones {
            let distance = position.distance(to: clone.position)
            if distance < closestDistance {
                closestDistance = distance
                closestClone = clone
            }
        }
        return closestClone
    }
}

extension CGPoint {
    func distance(to point: CGPoint) -> CGFloat {
        return sqrt(pow(x - point.x, 2) + pow(y - point.y, 2))
    }

    func normalized() -> CGPoint {
        let length = distance(to: .zero)
        return CGPoint(x: x / length, y: y / length)
    }

    static func - (left: CGPoint, right: CGPoint) -> CGPoint {
        return CGPoint(x: left.x - right.x, y: left.y - right.y)
    }

    static func * (point: CGPoint, scalar: CGFloat) -> CGPoint {
        return CGPoint(x: point.x * scalar, y: point.y * scalar)
    }

    static func += (left: inout CGPoint, right: CGPoint) {
        left = CGPoint(x: left.x + right.x, y: left.y + right.y)
    }
}
