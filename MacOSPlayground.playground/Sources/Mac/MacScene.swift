import Foundation

//
//  GameScene.swift
//  ProjectTouchBar
//
//  Created by Henrique Figueiredo Conte on 12/01/20.
//  Copyright © 2020 Henrique Figueiredo Conte. All rights reserved.
//

import Cocoa
import Foundation
import SpriteKit


class MacScene: SKScene {
    
    var playerNode: SKSpriteNode?
    var backgroundNode: SKSpriteNode?
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)

        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        backgroundNode = SKSpriteNode(color: NSColor(red: 1/255, green: 1/255, blue: 60/255, alpha: 1.0), size: CGSize(width: view.frame.size.width, height: view.frame.size.height))

        addChild(backgroundNode!)
        
        initScene()
    }
    
    
    func initScene() {
        
        let onboardMessage = SKLabelNode(text: "Click here to start")
        onboardMessage.position = CGPoint(x: 0, y: 0)
        onboardMessage.numberOfLines = 0
        onboardMessage.fontSize = (view?.frame.size.width ?? 0) * 0.05

        
        let fadeIn = SKAction.fadeIn(withDuration: 1.0)
        let fadeOut = SKAction.fadeOut(withDuration: 1.0)
        
        onboardMessage.run(SKAction.repeatForever(SKAction.sequence([fadeIn, fadeOut])))
        

        addChild(onboardMessage)
    }

    
    
}
