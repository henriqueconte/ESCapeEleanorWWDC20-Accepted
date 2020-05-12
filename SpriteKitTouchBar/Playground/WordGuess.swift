//
//  Hole.swift
//  SpriteKitTouchBar
//
//  Created by Henrique Figueiredo Conte on 07/05/20.
//  Copyright © 2020 Henrique Figueiredo Conte. All rights reserved.
//

import Foundation
import SpriteKit


class WordGuess: SKSpriteNode {
    
    var letterSlots: [SKLabelNode] = []
    var currentWord: String {
        var word: String = ""
        for element in letterSlots {
            word.append(element.text ?? "")
        }
        return word
    }
    
    override init(texture: SKTexture!, color: NSColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        self.name = "wordGuess"
        self.size = CGSize(width: 200, height: 30)
        setLetterSlots()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setLetterSlots() {
        
        var separator: Int = 0
        
        for i in 0..<5 {
            let newLetterSlot = SKLabelNode(text: "")
            newLetterSlot.fontSize = 15
            newLetterSlot.fontColor = .white
            newLetterSlot.fontName = "Arial Rounded MT Bold"
            newLetterSlot.zPosition = 1
            newLetterSlot.position = CGPoint(x: separator + (25 * i), y: 0)
            newLetterSlot.text = ""
            letterSlots.append(newLetterSlot)
            separator += 3
            
            let underLineBar = SKSpriteNode(color: .lightGray, size: CGSize(width: 25, height: 2))
            underLineBar.position = CGPoint(x: 0, y: -3)
        
            newLetterSlot.addChild(underLineBar)
            addChild(newLetterSlot)
        }
        
    }
    
    func readLetter(letter: String) -> Bool {
        
        // \u{7F} means delete key
        if letter == "\u{7F}" {
        
            for element in letterSlots.reversed() {
                if element.text != "" {
                    element.text = ""
                    break
                }
            }
            
        }
        else {
            
            for element in letterSlots {
                if element.text == "" {
                    element.text = letter
                    if element == letterSlots.last {
                        if currentWord.lowercased() == "swift" {
                            correctWord()
                            
                            return true
                        }
                        else {
                            wrongWord()
                        }
                    }
                    else {
                        break
                    }
                }
            }
            
        }
        
        return false
    }
    
    func correctWord() {
        let colorToBlue = SKAction.colorize(with: NSColor(red: 60/255, green: 153/255, blue: 252/255, alpha: 1), colorBlendFactor: 1.0, duration: 0.5)
        let colorToWhite = SKAction.colorize(with: NSColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1), colorBlendFactor: 1.0, duration: 0.5)
        
        for element in letterSlots {
            element.run(SKAction.sequence([colorToBlue, colorToWhite, colorToBlue, colorToWhite])) {
                
            }
        }
    }
    
    func wrongWord() {
        let colorToRed = SKAction.colorize(with: NSColor(red: 226/255, green: 21/255, blue: 21/255, alpha: 1), colorBlendFactor: 1.0, duration: 0.5)
        let colorToWhite = SKAction.colorize(with: NSColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1), colorBlendFactor: 1.0, duration: 0.5)
        
        for element in letterSlots {
            element.run(SKAction.sequence([colorToRed, colorToWhite])) {
                element.text = ""
            }
        }
    }
    
}
