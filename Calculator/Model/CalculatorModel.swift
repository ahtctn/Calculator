//
//  CalculatorModel.swift
//  Calculator
//
//  Created by Ahmet Ali ÇETİN on 26.07.2023.
//

import Foundation

class CalculatorModel {
    private var currentValue: Double = 0
    private var storedValue: Double?
    private var currentOperator: String?
    
    func setCurrentValue(_ value: Double) {
        currentValue = value
    }
    
    func setOperator(_ operatorSymbol: String) {
        currentOperator = operatorSymbol
        storedValue = currentValue
        currentValue = 0
    }
    
    func calculateResult() -> Double? {
        guard let operatorSymbol = currentOperator, let storedValue = storedValue else {
            return nil
        }
        
        switch operatorSymbol {
        case "+":
            return storedValue + currentValue
        case "-":
            return storedValue - currentValue
        case "x":
            return storedValue * currentValue
        case "/":
            return currentValue != 0 ? storedValue / currentValue : nil
        default:
            return nil
        }
    }
    
    func reset() {
        currentValue = 0
        storedValue = nil
        currentOperator = nil
    }
    
    func getCurrentValue() -> Double {
        return currentValue
    }
    
    func getCurrentValueString() -> String {
        // Only show decimal point if decimalEntered is true
        return String(format: decimalEntered ? "%.2f" : "%.0f", currentValue)
    }
    
    // Add a variable to track if the decimal point is entered
    var decimalEntered = false
}
