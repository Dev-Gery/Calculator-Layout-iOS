//
//  ViewController.swift
//  Calculator Layout iOS13
//
//  Created by Angela Yu on 01/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak private var displayLabel: UILabel!
    private var isFinishedTypingNumber: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func calcButtonPressed(_ sender: UIButton) {
        isFinishedTypingNumber = true
        
        guard let title = sender.currentTitle else {fatalError("The button just pressed does not have a title or operator symbol")}
        
        switch title.trimmingCharacters(in: .whitespaces) {
        case "%":
            isFinishedTypingNumber = false
            var result = String(describing: Float(displayLabel.text!)! / 100)
            let removeWholeZeroFromResult = {
                result.remove(at: result.index(after: result.startIndex))
                return result
            }
            displayLabel.text = displayLabel.text!.hasPrefix("0") || displayLabel.text!.hasPrefix("-0") ? result : displayLabel.text!.hasPrefix("-.") ? removeWholeZeroFromResult() : result[result.index(after: result.startIndex)] == "0" ? removeWholeZeroFromResult() : result
        case "+/-":
            isFinishedTypingNumber = false
            if let displayText = displayLabel.text?.trimmingCharacters(in: .whitespaces) {
                if displayText.starts(with: "-") {
                    displayLabel.text = displayText.count == 1 ? {isFinishedTypingNumber = true; return "0"}() : String(displayText.suffix(displayText.count - 1))
                } else {
                    displayLabel.text = displayText == "0" ? "-" : "-" + displayText
                }
            }
        case "AC":
            displayLabel.text = "0"
//        case _ where title.contains("÷"):
        default:
            print("the button with the title is not handled yet")
        }
    }
    
    @IBAction func numButtonPressesd(_ sender: UIButton) {
        
        guard let numValue = sender.currentTitle else {
            fatalError("The button just pressed has no title or number value")
        }
        
        switch isFinishedTypingNumber {
        case true:
            isFinishedTypingNumber = numValue != "0" ? {
                numValue == "." ? {
                    displayLabel.text == "0" ? (displayLabel.text = "0.") : (displayLabel.text = ".")
                }() : {
                    displayLabel.text = numValue
                }()
                return false
            }() : {
                displayLabel.text = "0"
                return true
            }()
        default:
            let displayText = displayLabel.text! + numValue
            if displayText.count - displayText.replacingOccurrences(of: ".", with: "").count <= 1 {
                displayLabel.text! += numValue
            } else {
                ()
            }
        }
        
    }
    
}


