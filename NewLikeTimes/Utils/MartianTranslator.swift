//
//  MartianTranslator.swift
//  NewLikeTimes
//
//  Created by Jing Wang on 11/11/22.
//

import Foundation

class MartianTranslator {
    static var shared = MartianTranslator()
    
    private init() {}
    
    func getMartian(_ origEngText: String) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        
        var engWord = ""
        var martianWord = ""
        var martianText = ""
        
        //        for ch in engText {
        for idx in 0..<origEngText.count {
            let ch: Character = origEngText[idx]
            //            print("\(ch)")
            if ch.isLetter || ch.isNumber {
                engWord.append(String(ch))
            } else if ch == "," {
                // 2,000. -> num
                // 2.     -> '/0'
                // 2,000, eng ->
                
                // current engWord is a number
                if let num = Int(engWord)  {
                    if !origEngText[idx + 1].isNumber {
                        guard
                            let formattedNum =  formatter.string(from: NSNumber(value: num)) else {
                            fatalError("Failed to convert num to decimal format")
                        }
                        
                        martianText += formattedNum + String(ch)
                        engWord = ""
                    }
                } else {
                    martianWord = engWord.count > 3 ? covertToMartianWord(engWord) : engWord
                    martianText += martianWord + String(ch)
                    engWord = ""
                }
                
            } else {
                if let num = Int(engWord)  {
                    guard
                        let formattedNum =  formatter.string(from: NSNumber(value: num)) else {
                        fatalError("Failed to convert num to decimal format")
                    }
                    
                    martianText += formattedNum + String(ch)
                    engWord = ""
                } else {
                    martianWord = engWord.count > 3 ? covertToMartianWord(engWord) : engWord
                    martianText += martianWord + String(ch)
                    engWord = ""
                }
                
            }
        }
        
        return martianText
    }
}


private func covertToMartianWord(_ word:String) -> String {
    let encryption1 = "Boinga"
    let encryption2 = "boinga"
    
    // e.g. 2,500
    var martianWord = ""
    if let _ = Int(word) {
        return word
    }
    
    if word.count <= 3 {
        martianWord = word
    } else {
        return word.first?.isUppercase == true ? encryption1 : encryption2
    }
    return martianWord
}
