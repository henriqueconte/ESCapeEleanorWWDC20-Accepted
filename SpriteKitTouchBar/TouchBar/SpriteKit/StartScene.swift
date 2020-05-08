//
//  StartScene.swift
//  SpriteKitTouchBar
//
//  Created by Henrique Figueiredo Conte on 24/04/20.
//  Copyright © 2020 Henrique Figueiredo Conte. All rights reserved.
//

import Foundation
import SpriteKit


class StartScene: SKScene {
    var backgroundNode: SKSpriteNode?

    override func didMove(to view: SKView) {
        setBackground()
        setInstructionsText()
        setKeyboardEvents()
    }

    func setBackground() {
        backgroundNode = SKSpriteNode(texture: SKTexture(imageNamed: "spaceBackground"), size: CGSize(width: self.view?.bounds.width ?? 0, height: self.view?.bounds.height ?? 0))
        backgroundNode?.zPosition = 0
        backgroundNode?.anchorPoint = CGPoint(x: 0, y: 0)

        addChild(backgroundNode!)
    }

    func setInstructionsText() {

        let fadeIn = SKAction.fadeIn(withDuration: 0.75)
        let fadeOut = SKAction.fadeOut(withDuration: 0.75)
        let loopAction = SKAction.repeatForever(SKAction.sequence([fadeIn, fadeOut]))

        let instructionLabel = SKLabelNode(text: "Press space to play")
        instructionLabel.position = CGPoint(x: 200, y: 10)
        instructionLabel.fontName = "Arial Rounded MT Bold"
        instructionLabel.fontSize = 15
        instructionLabel.fontColor = .white
        instructionLabel.zPosition = 1

        addChild(instructionLabel)
        instructionLabel.run(loopAction)
    }

    func setKeyboardEvents() {

        NSEvent.addLocalMonitorForEvents(matching: .keyDown) { (event) -> NSEvent? in

            switch event.keyCode {

            case KeyIdentifiers.space.rawValue:
                self.showGameScene()

            default:
                return event
            }
            return event
        }
    }

    func showGameScene() {
        let scene = SKScene(fileNamed: "Game") as? GameScene
        scene!.scaleMode = .aspectFill
        self.view?.presentScene(scene)
    }
}


