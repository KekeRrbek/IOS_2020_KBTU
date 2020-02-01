//
//  calculator.swift
//  calculator
//
//  Created by Ернар on 26.01.20.
//  Copyright © 2020 Ернар. All rights reserved.
//

import Foundation

class Calculator {
    // MARK: - Constants
    enum Operation {
        case equals
        case constant(value: Double)
        case unary(function: (Double) -> Double)
        case binary(function: (Double, Double) -> Double)
        case clean
    }
    
    var map: [String : Operation] = [
        "+" : .binary { $0 + $1 },
        "-" : .binary { $0 - $1 },
        "*" : .binary { $0 * $1 },
        "/" : .binary { $0 / $1 },
        "Sqrt" : .unary { sqrt($0) },
        "=" : .equals,
        "%" : .unary {$0 / 100},
        "x^y" : .binary {pow($0,$1)},
        "x!" : .unary { n in
            if n == 0 {
                return 1
            }
            var a: Double = 1
            for i in 1...Int(n) {
                a *= Double(i)
            }
            return a
        }
        ,
        "C" : .clean
]
    
    // MARK: - Variables
    var result: Double = 0
    var lastBinaryOperation: ((Double, Double) -> Double)?
    var reminder: Double = 0
    
    // MARK: - Methods
    func setOperand(number: Double) {
        result = number
    }
    
    func executeOperation(symbol: String) {
        guard let operation = map[symbol] else {
            print("ERROR: no such symbol in map")
            return
        }
        
        switch operation {
        case .clean:
            result = 0
            lastBinaryOperation = nil
            reminder = 0 
        case .constant(let value):
            result = value
        case .unary(let function):
            result = function(result)
        case .binary(let function):
            if lastBinaryOperation != nil {
                executeOperation(symbol: "=")
            }
            
            lastBinaryOperation = function
            reminder = result
            
        case .equals:
            if let lastOperation = lastBinaryOperation {
                result = lastOperation(reminder, result)
                lastBinaryOperation = nil
                reminder = 0
            }
            
        }
    }
    
    
}
