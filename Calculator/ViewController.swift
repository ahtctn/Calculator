//
//  ViewController.swift
//  Calculator
//
//  Created by Ahmet Ali ÇETİN on 26.07.2023.
//
import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var resultLabel: UILabel!
    
    var calculator = CalculatorModel()
    var isTypingNumber = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateResultLabel()
    }
    
    // Helper method to update the result label
    func updateResultLabel() {
        resultLabel.text = calculator.getCurrentValueString()
    }
    
    // Button actions
    @IBAction func numberButtonTapped(_ sender: UIButton) {
        if let numberText = sender.titleLabel?.text, let number = Double(numberText) {
            if isTypingNumber {
                if calculator.decimalEntered {
                    // Handle decimal numbers
                    if let dotIndex = resultLabel.text?.firstIndex(of: ".") {
                        let decimalPlace = 1.0 / pow(10, Double(resultLabel.text!.count - resultLabel.text!.distance(from: resultLabel.text!.startIndex, to: dotIndex) - 1))
                        let updatedValue = calculator.getCurrentValue() + number * decimalPlace
                        calculator.setCurrentValue(updatedValue)
                    }
                } else {
                    let updatedValue = calculator.getCurrentValue() * 10 + number
                    calculator.setCurrentValue(updatedValue)
                }
            } else {
                calculator.setCurrentValue(number)
                isTypingNumber = true
            }
            updateResultLabel()
        }
    }
    
    @IBAction func operatorButtonTapped(_ sender: UIButton) {
        if let operatorSymbol = sender.titleLabel?.text {
            if isTypingNumber {
                calculator.setOperator(operatorSymbol)
                isTypingNumber = false
                calculator.decimalEntered = false
            }
        }
    }
    
    @IBAction func equalsButtonTapped(_ sender: UIButton) {
        if isTypingNumber {
            if let result = calculator.calculateResult() {
                calculator.setCurrentValue(result)
                updateResultLabel()
                isTypingNumber = false
                calculator.decimalEntered = false
            } else {
                resultLabel.text = "Error"
            }
        }
    }
    
    @IBAction func clearButtonTapped(_ sender: UIButton) {
        calculator.reset()
        updateResultLabel()
        isTypingNumber = false
        calculator.decimalEntered = false
    }
    
    // Decimal button action
    @IBAction func decimalButtonTapped(_ sender: UIButton) {
        if !calculator.decimalEntered {
            calculator.decimalEntered = true
            isTypingNumber = true
            
            // Append a decimal point (".") to the resultLabel
            resultLabel.text = resultLabel.text! + "."
        }
    }
}
