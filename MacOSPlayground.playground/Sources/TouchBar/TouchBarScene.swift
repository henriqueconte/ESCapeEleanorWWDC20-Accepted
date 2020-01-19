import Foundation

//
//  GameScene.swift
//  ProjectTouchBar
//
//  Created by Henrique Figueiredo Conte on 12/01/20.
//  Copyright © 2020 Henrique Figueiredo Conte. All rights reserved.
//


// TOUCH BAR SIZE: WIDTH: 685, HEIGHT: 30
import Cocoa
import Foundation
import SpriteKit


class TouchBarScene: SKScene {
    
    var playerNode: SKSpriteNode?
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)

        //print("Tamanho touch bar:", view.frame)
        view.setFrameSize(NSSize(width: 685, height: 30))
        
        
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        //let node = SKSpriteNode(color: NSColor(red: 100/255, green: 1/255, blue: 60/255, alpha: 1.0), size: CGSize(width: view.frame.size.width, height: view.frame.size.height))
        let node = SKSpriteNode(color: NSColor(red: 100/255, green: 1/255, blue: 60/255, alpha: 1.0), size: CGSize(width: 1, height: 1))
        addChild(node)
        
        initScene()
        setKeyboardEvents()
        
        //self.backgroundColor = .yellow
    }
    
    
    func initScene() {
        playerNode = SKSpriteNode()
        playerNode?.color = NSColor(red: 1/255, green: 255/255, blue: 20/255, alpha: 1.0)
        playerNode?.size = CGSize(width: 0.02189784219, height: 0.5)
        playerNode?.position = CGPoint(x: 0 , y: 0)
        
//        let oneRevolution:SKAction = SKAction.rotate(byAngle: CGFloat.pi * 2, duration: 1)
//        let repeatRotation:SKAction = SKAction.repeatForever(oneRevolution)
//
//        playerNode?.run(repeatRotation)
        
        addChild(playerNode!)

    }
    
    func setKeyboardEvents() {
        
        NSEvent.addLocalMonitorForEvents(matching: .keyUp) { (event) -> NSEvent? in
            
            switch event.keyCode {
            case KeyIdentifiers.upArrow.rawValue:
                self.playerNode?.position.y += 0.2
            case KeyIdentifiers.downArrow.rawValue:
                self.playerNode?.position.y -= 0.2
            case KeyIdentifiers.leftArrow.rawValue:
                self.playerNode?.position.x -= 0.2
            case KeyIdentifiers.rightArrow.rawValue:
                self.playerNode?.position.x += 0.2
                
            default:
                return event
            }
            
            return event
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        playerNode?.position.x += 0.001
    }
    
    
    
}
