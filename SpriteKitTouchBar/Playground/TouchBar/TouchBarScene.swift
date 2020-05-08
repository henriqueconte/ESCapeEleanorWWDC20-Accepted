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
    
    var playerNodes: [PixelNode]?
    var playerNodeXPosition: [Int] = [5,4,5,6,5]
    var playerNodeYPosition: [Int] = [1,2,3]
    var playerCentralNode: PixelNode?
    var playerLightNodes: [SKLightNode] = []
    var removedLightNodes: Int = 0
    
    var charNode: MainCharacter?
    
    var backgroundNodeList: [Int : [PixelNode]] = [ : ]
    var touchBarHeightCount: Int = 0
    var touchBarWidthCount: Int = 0
    
    let affectedBitmask: UInt32 = 0b0001
    let notAffectedBitmask: UInt32 = 333333
    
    //var macScene: MacScene?
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)

        self.isUserInteractionEnabled = true
        view.setFrameSize(NSSize(width: 685, height: 30))
        
        
        self.anchorPoint = CGPoint(x: 0, y: 0)
        
        let node = SKSpriteNode(color: NSColor(red: 1/255, green: 80/255, blue: 60/255, alpha: 0), size: CGSize(width: 1, height: 1))
        node.position = CGPoint(x: 0, y: 0)
        node.anchorPoint = CGPoint(x: 0, y: 0)
        applyAffectedBitmask(node: node)
        node.lightingBitMask = affectedBitmask
        
        addChild(node)
        //fillScreen(nodeWidth: MultiplierFactor.proportionalWidth(height: 0.19), nodeHeight: 0.19, separatorSize: 0.01)
        fillScreen(nodeWidth: MultiplierFactor.proportionalWidth(height: 0.2), nodeHeight: 0.2, separatorSize: 0)
        initScene()
        setKeyboardEvents()
        addPlayer(onPoint: CGPoint(x: 0.05, y: 0.5))
        setLightNode()
        addRock(onPoint: CGPoint(x: 0.5, y: 0.5))
        
    }
    
    
    func initScene() {
        
        createPlayerNodes()
        
//        let oneRevolution:SKAction = SKAction.rotate(byAngle: CGFloat.pi * 2, duration: 1)
//        let repeatRotation:SKAction = SKAction.repeatForever(oneRevolution)
//
//        playerNode?.run(repeatRotation)
    }
    
    func addRock(onPoint: CGPoint) {
        let rockNode = SKSpriteNode(texture: SKTexture(imageNamed: "darkRock"))
        rockNode.size = CGSize(width: MultiplierFactor.proportionalWidth(height: 0.42), height: 0.42)
        rockNode.position = onPoint
        applyAffectedBitmask(node: rockNode)
        rockNode.lightingBitMask = affectedBitmask
        rockNode.zPosition = 100000
        
        addChild(rockNode)
    }
    
    func addPlayer(onPoint: CGPoint) {
        charNode = MainCharacter(texture: SKTexture(imageNamed: "charRight1"), size: CGSize(width: MultiplierFactor.proportionalWidth(height: 0.42),
                                                                                                height: 0.6))
        charNode?.texture = SKTexture(imageNamed: "charRight1")
        charNode?.position = onPoint
        applyAffectedBitmask(node: charNode!)
        charNode?.lightingBitMask = affectedBitmask
        charNode?.zPosition = 100000
        
        addChild(charNode!)
    }
    
    func fillScreen(nodeWidth: CGFloat, nodeHeight: CGFloat, separatorSize: CGFloat) {
        var currentWidthPosition: CGFloat = 0
        var currentHeightPosition: CGFloat = 0
        var arrayLineCount: Int = 0
        var pixelLine: [PixelNode] = []
        
        while currentHeightPosition < 1 {
            
            touchBarWidthCount = 0
            touchBarHeightCount += 1
            
            while currentWidthPosition < 1 {
                let pixelNode = PixelNode(color: .yellow, size: CGSize(width: nodeWidth, height: nodeHeight))
                pixelNode.position = CGPoint(x: currentWidthPosition, y: currentHeightPosition)
                pixelNode.anchorPoint = CGPoint(x: 0, y: 0)
                pixelNode.lightingBitMask = affectedBitmask
                applyAffectedBitmask(node: pixelNode)
                
                addChild(pixelNode)
                
                currentWidthPosition += nodeWidth + MultiplierFactor.proportionalWidth(height: separatorSize)
                pixelLine.append(pixelNode)
            
                touchBarWidthCount += 1
                
                if touchBarHeightCount == 1 {
                    pixelNode.texture = SKTexture(imageNamed: "groundTexture")
                }
                else if touchBarHeightCount > 1 {
                    pixelNode.texture = SKTexture(imageNamed: "stoneTexture3")
                }
            }
                
            backgroundNodeList[arrayLineCount] = pixelLine
            
            currentHeightPosition += nodeHeight + separatorSize
            arrayLineCount += 1
            currentWidthPosition = 0
            
            pixelLine = []
        }
        
    }
    
    func setKeyboardEvents() {
        
        NSEvent.addLocalMonitorForEvents(matching: .keyDown) { (event) -> NSEvent? in

            switch event.keyCode {
            case KeyIdentifiers.upArrow.rawValue:
                self.movePlayerNodes(direction: .vertical, distance: 1)
                self.charNode?.moveRight()
                
            case KeyIdentifiers.downArrow.rawValue:
                self.movePlayerNodes(direction: .vertical, distance: -1)
                self.charNode?.moveLeft()

            case KeyIdentifiers.leftArrow.rawValue:
                self.movePlayerNodes(direction: .horizontal, distance: -1)
                self.charNode?.moveLeft()
                
            case KeyIdentifiers.rightArrow.rawValue:
                self.movePlayerNodes(direction: .horizontal, distance: 1)
                self.charNode?.moveRight()
                
            case KeyIdentifiers.space.rawValue:
                
                if self.playerLightNodes.isEmpty == false {
                    
                    if self.playerLightNodes.count == 1 {

                        self.playerLightNodes.first?.removeFromParent()
                        self.playerLightNodes.first?.falloff = 1.0
                        self.addChild(self.playerLightNodes.first ?? SKNode())
                        
//                        self.macScene?.backgroundNode?.color = NSColor(red: 255/255, green: 1/255, blue: 100/255, alpha: 0.8)
                    }
                    else {
                        self.playerLightNodes.last?.removeFromParent()
                        self.playerLightNodes.removeLast()
                        self.removedLightNodes += 1
                    }

                }
                
            default:
                return event
            }
            return event
        }
    }
    
    func createPlayerNodes() {
        playerNodes =
            [
            (backgroundNodeList[playerNodeYPosition[0]]?[playerNodeXPosition[0]] ?? PixelNode()),
            (backgroundNodeList[playerNodeYPosition[1]]?[playerNodeXPosition[1]] ?? PixelNode()),
            (backgroundNodeList[playerNodeYPosition[1]]?[playerNodeXPosition[2]] ?? PixelNode()),
            (backgroundNodeList[playerNodeYPosition[1]]?[playerNodeXPosition[3]] ?? PixelNode()),
            (backgroundNodeList[playerNodeYPosition[2]]?[playerNodeXPosition[4]] ?? PixelNode())
        ]
        
        playerCentralNode = playerNodes?[Int((playerNodes?.count ?? 0) / 2)]
        
        //charNode?.position.x = playerCentralNode?.position.x ?? 0
        charNode?.setNewPosition(onPoint: CGPoint(x: playerCentralNode?.position.x ?? 0, y: charNode?.position.y ?? 0),
                                 duration: 0.1)
        
        for element in playerNodes ?? [] {
            element.color = NSColor(red: 1/255, green: 255/255, blue: 20/255, alpha: 1.0)
            element.pixelCategory = .player
            applyNotAffectedBitmask(node: element)
        }
        
        setLightNode()
    }
    
    func hidePlayerNodes() {
        for element in playerNodes ?? [] {
            element.color = .yellow
            element.pixelCategory = .background
        }
        
        for element in playerLightNodes {
            element.removeFromParent()
        }
        
        playerLightNodes.removeAll()
    }
    
    func movePlayerNodes(direction: Direction, distance: Int) {
        
        var movementAllowed: Bool = true

        for element in playerNodeXPosition {
            if (element + distance > touchBarWidthCount - 1 || element + distance < 0) && direction == .horizontal {
                movementAllowed = false
            }
        }
        
        for element in playerNodeYPosition {
            if (element + distance > touchBarHeightCount || element + distance < 0) && direction == .vertical {
                movementAllowed = false
            }
        }
        
        if movementAllowed {
            
            hidePlayerNodes()
            playerNodes = []
            
            switch direction {
            case .vertical:
                for i in 0..<playerNodeYPosition.count {
                    playerNodeYPosition[i] += distance
                }
                
            case .horizontal:
                for i in 0..<playerNodeXPosition.count {
                    playerNodeXPosition[i] += distance
                }
            }
            createPlayerNodes()
        }
    }
    
    func setLightNode() {
        
        if playerLightNodes.isEmpty {
            
            playerCentralNode?.zPosition = 100
            
            for _ in 0..<4 - removedLightNodes {
                let lightNode = SKLightNode()
//                lightNode.position = CGPoint(x: (playerCentralNode?.position.x ?? 0) + 0.004,
//                                             y: (playerCentralNode?.position.y ?? 0) + 0.05)
                lightNode.position = CGPoint(x: (playerCentralNode?.position.x ?? 0) + 0.004,
                                             y: 1.1)
                lightNode.ambientColor = .clear
                lightNode.lightColor = .white
                lightNode.falloff = 0
                lightNode.zPosition = 1
                
                applyAffectedBitmask(node: lightNode)
                playerLightNodes.append(lightNode)
                
                addChild(lightNode)
            }
        }
    }
    
    func applyAffectedBitmask(node: SKNode) {
        node.physicsBody?.categoryBitMask = affectedBitmask
    }
    
    func applyNotAffectedBitmask(node: SKNode) {
        node.physicsBody?.categoryBitMask = notAffectedBitmask
    }
    
    override func update(_ currentTime: TimeInterval) {

    }
    
    
    
}
