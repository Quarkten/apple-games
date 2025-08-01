import UIKit
import SpriteKit

class FormationDrawer {
    // Properties
    private var path: UIBezierPath?
    private var scene: SKScene

    // Initializer
    init(scene: SKScene) {
        self.scene = scene
        setupGestureRecognizer()
    }

    // Methods
    private func setupGestureRecognizer() {
        let gestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        scene.view?.addGestureRecognizer(gestureRecognizer)
    }

    @objc private func handlePan(_ gestureRecognizer: UIPanGestureRecognizer) {
        let location = gestureRecognizer.location(in: scene.view)
        let sceneLocation = scene.convertPoint(fromView: location)

        switch gestureRecognizer.state {
        case .began:
            path = UIBezierPath()
            path?.move(to: sceneLocation)
        case .changed:
            path?.addLine(to: sceneLocation)
            // Draw the path on the screen for visual feedback
        case .ended:
            // Finalize the path and move troops
            break
        default:
            break
        }
    }
}
