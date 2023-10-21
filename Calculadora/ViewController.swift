//
//  ViewController.swift
//  Calculadora
//
//  Created by CinNun on 10/10/23.
//
import UIKit
import os

class ViewController: UIViewController {
    // MARK: Define private values from class
    private enum Operations: Int {
        case reset = 15
        case add = 18
        case divided = 14
        case multiplication = 13
        case substract = 12
        
        var operation: String {
            switch self {
            case .add:
                return "+"
            case .divided:
                return "/"
            case .multiplication:
                return "*"
            case .substract:
                return "-"
            default:
                return ""
            }
        }
    }
    @IBOutlet private weak var labelOperation: UILabel!
    @IBOutlet private weak var labelResult: UILabel!
    private let logger = Logger()
    private var operation = ""
    
    // MARK: Lifecycle App
    /**
     This method is part of the view controller's lifecycle and is called when the view has finished loading. It initializes the calculator by calling the `clearData` function.
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        clearData()
    }
    
    //MARK: events for calculator buttons
    /**
     This method is called when an operation button (e.g., addition, subtraction) is tapped in the calculator interface. It logs the button's tag value, determines the operation to be performed, and updates the calculator's operation string accordingly. It may also clear data if the operation is a reset.
     - Parameter sender: The UIButton representing the tapped operation.
     */
    @IBAction func numberTap(_ sender: UIButton) {
        logger.debug("TAG = \(sender.tag)")
        addValue(value: String(sender.tag))
    }
    
    /**
     This method is called when an operation button (e.g., addition, subtraction) is tapped in the calculator interface. It logs the button's tag value, determines the operation to be performed, and updates the calculator's operation string accordingly. It may also clear data if the operation is a reset.
     - Parameter sender: The UIButton representing the tapped operation.
     */
    @IBAction func operationTap(_ sender: UIButton) {
        logger.debug("TAG = \(sender.tag)")
        let enumOperation = Operations(rawValue: sender.tag)
        if enumOperation == .reset {
            clearData()
        } else {
            addValue(value: enumOperation?.operation ?? "")
        }
    
    }
    
    /**
     This method is called when the equals button is tapped in the calculator interface. It logs the button's tag value, evaluates the expression contained in the `operation` string, and displays the result in the calculator's result label after formatting it.
     - Parameter sender: The UIButton representing the equals button.
     */
    @IBAction func equalsTap(_ sender: UIButton) {
        logger.debug("TAG = \(sender.tag)")
        let tempOperation = (operation.last ?? Character(" ")).isNumber
        if (tempOperation) {
            let expersion = NSExpression(format: operation)
            let result = expersion.expressionValue(with: nil, context: nil) as! Double
            
            labelResult.text = formatResult(result)
        }
    }
    
    //MARK: General functions for calculator
    /**
     This function appends a numeric value or an operation symbol to the `operation` string, updating the displayed operation in the calculator's UI.
     - Parameter value: The value (number or operation symbol) to be added to the operation.
     */
    private func addValue(value: String) {
        operation = operation + String(value)
        labelOperation.text = operation
    }
    
    /**
     This function clears the calculator's data, setting the `operation` string and the labels for operation and result to empty values.
     */
    private func clearData() {
        operation = ""
        labelOperation.text = ""
        labelResult.text = ""
    }
    
    /**
     This function formats the result of a calculation, ensuring that whole numbers are displayed without decimal places and other numbers are displayed with two decimal places.
     - Parameter result: The result of the calculation to be formatted.
     - Returns: A formatted string representing the result.
     */
    private func formatResult(_ result: Double) -> String {
        if result.truncatingRemainder(dividingBy: 1) == 0 {
            return String(format: "%.0f", result)
        } else {
            return String(format: "%.2f", result)
        }
    }
}
