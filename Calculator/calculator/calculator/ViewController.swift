//
//  ViewController.swift
//  calculator
//
//  Created by Ернар on 26.01.20.
//  Copyright © 2020 Ернар. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let model = Calculator()
    
    @IBOutlet weak var resultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    @IBAction func numberPressed(_ sender: UIButton) {
        guard
            let numberText = sender.titleLabel?.text
            else { return }
        
        resultLabel.text?.append(numberText)
    }
    
    
    @IBAction func operationPressed(_ sender: UIButton) {
        guard
            let numberText = resultLabel.text,
            let number = Double(numberText),
            let operation = sender.titleLabel?.text
            else {
                return
        }
        
        resultLabel.text = ""
        model.setOperand(number: number)
        model.executeOperation(symbol: operation)
        
        if operation == "=" {
            resultLabel.text = "\(model.result)"
        }
    }
}


