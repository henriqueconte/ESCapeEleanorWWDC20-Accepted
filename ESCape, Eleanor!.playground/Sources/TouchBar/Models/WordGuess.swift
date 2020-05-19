import Foundation
import SpriteKit


// Mini game to guess the char favorite programming language
public class WordGuess: SKSpriteNode {
    
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
    
    // MARK:- Sets initial elements
    
    // This creates the label nodes with the SKSpriteNodes to indicate slots for letters
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
    
    // Treats the letter sent by the user
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
    
    // Called when the user guessed the word correctly
    func correctWord() {
        let colorToBlue = SKAction.colorize(with: NSColor(red: 60/255, green: 153/255, blue: 252/255, alpha: 1), colorBlendFactor: 1.0, duration: 0.5)
        let colorToWhite = SKAction.colorize(with: NSColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1), colorBlendFactor: 1.0, duration: 0.5)
        
        for element in letterSlots {
            element.run(SKAction.sequence([colorToBlue, colorToWhite, colorToBlue, colorToWhite])) {
                
            }
        }
        
        let soundAction = SKAction.playSoundFileNamed("successSound.mp3", waitForCompletion: false)
        let wait = SKAction.wait(forDuration: 0.3)
        let soundSequence = SKAction.sequence([soundAction, wait, soundAction, wait, soundAction])
        
        self.run(soundSequence)
    }
    
    // Called when the user guessed the word incorrectly
    func wrongWord() {
        let colorToRed = SKAction.colorize(with: NSColor(red: 226/255, green: 21/255, blue: 21/255, alpha: 1), colorBlendFactor: 1.0, duration: 0.5)
        let colorToWhite = SKAction.colorize(with: NSColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1), colorBlendFactor: 1.0, duration: 0.5)
        
        for element in letterSlots {
            element.run(SKAction.sequence([colorToRed, colorToWhite])) {
                element.text = ""
            }
        }
        
        let soundAction = SKAction.playSoundFileNamed("failSound.m4a", waitForCompletion: false)
        let wait = SKAction.wait(forDuration: 0.3)
        let soundSequence = SKAction.sequence([soundAction, wait, soundAction, wait, soundAction])
        
        self.run(soundSequence)
    }
    
}
