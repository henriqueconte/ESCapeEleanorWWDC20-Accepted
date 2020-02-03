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
    
    var playerNodes: [PixelNode]?
    var playerNodeXPosition: [Int] = [5,4,5,6,5]
    var playerNodeYPosition: [Int] = [1,2,3]
    var playerCentralNode: PixelNode?

    var playerLightNode: SKLightNode?
    
    var backgroundNodeList: [Int : [PixelNode]] = [ : ]
    var touchBarHeightCount: Int = 0
    var touchBarWidthCount: Int = 0
    
    let affectedBitmask: UInt32 = 0b0001
    let notAffectedBitmask: UInt32 = 333333
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)

        self.isUserInteractionEnabled = true
        view.setFrameSize(NSSize(width: 685, height: 30))
        
        
        self.anchorPoint = CGPoint(x: 0, y: 0)
        
        let node = SKSpriteNode(color: NSColor(red: 1/255, green: 80/255, blue: 60/255, alpha: 1.0), size: CGSize(width: 1, height: 1))
        node.position = CGPoint(x: 0, y: 0)
        node.anchorPoint = CGPoint(x: 0, y: 0)
        applyAffectedBitmask(node: node)
        node.lightingBitMask = affectedBitmask
        
        addChild(node)
        
        fillScreen(nodeWidth: MultiplierFactor.proportionalWidth(height: 0.19), nodeHeight: 0.19, separatorSize: 0.01)
        initScene()
        setKeyboardEvents()
        setLightNode()
    }
    
    
    func initScene() {
        
        createPlayerNodes()
        
//        let oneRevolution:SKAction = SKAction.rotate(byAngle: CGFloat.pi * 2, duration: 1)
//        let repeatRotation:SKAction = SKAction.repeatForever(oneRevolution)
//
//        playerNode?.run(repeatRotation)
    }
    
    func fillScreen(nodeWidth: CGFloat, nodeHeight: CGFloat, separatorSize: CGFloat) {
        var currentWidthPosition: CGFloat = 0
        var currentHeightPosition: CGFloat = 0
        var arrayLineCount: Int = 0
        var pixelLine: [PixelNode] = []
        
        while currentHeightPosition < 1 {
            
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
            }
                
            backgroundNodeList[arrayLineCount] = pixelLine
            
            currentHeightPosition += nodeHeight + separatorSize
            arrayLineCount += 1
            touchBarHeightCount += 1
            currentWidthPosition = 0
            touchBarWidthCount = 0
            pixelLine = []
        }
        
    }
    
    func setKeyboardEvents() {
        
        NSEvent.addLocalMonitorForEvents(matching: .keyUp) { (event) -> NSEvent? in

            switch event.keyCode {
            case KeyIdentifiers.upArrow.rawValue:
                self.movePlayerNodes(direction: .vertical, value: 1)
            case KeyIdentifiers.downArrow.rawValue:
                self.movePlayerNodes(direction: .vertical, value: -1)
            case KeyIdentifiers.leftArrow.rawValue:
                self.movePlayerNodes(direction: .horizontal, value: -1)
            case KeyIdentifiers.rightArrow.rawValue:
                self.movePlayerNodes(direction: .horizontal, value: 1)

//            case KeyIdentifiers.space.rawValue:
//
//            self.playerNode?.run(SKAction.resize(toWidth: 0.03503649635, height: 0.8, duration: 1))

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
        playerLightNode?.removeFromParent()
        playerLightNode = nil
    }
    
    func movePlayerNodes(direction: Direction, value: Int) {
        hidePlayerNodes()
        playerNodes = []
        
        switch direction {
        case .vertical:
            for i in 0..<playerNodeYPosition.count {
                playerNodeYPosition[i] += value
            }
            
        case .horizontal:
            for i in 0..<playerNodeXPosition.count {
                playerNodeXPosition[i] += value
            }
        }
        
        createPlayerNodes()
        
    }
    
    func setLightNode() {
    
        if playerLightNode == nil {

            playerCentralNode?.zPosition = 100
            
            playerLightNode = SKLightNode()
            playerLightNode?.position = playerCentralNode?.position ?? CGPoint(x: 0, y: 0)
            playerLightNode?.ambientColor = .clear
            playerLightNode?.lightColor = .white
            playerLightNode?.falloff = 0
            playerLightNode?.zPosition = 1
            
            applyAffectedBitmask(node: playerLightNode!)

            addChild(playerLightNode!)
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
