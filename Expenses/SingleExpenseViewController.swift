//
//  SingleExpenseViewController.swift
//  Expenses
//
//  Created by Eric Mitchell on 4/18/19.
//  Copyright © 2019 Eric Mitchell. All rights reserved.
//

import UIKit

class SingleExpenseViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var amountTextField: UITextField!
    
    var existingExpense: Expense?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameTextField.delegate = self
        amountTextField.delegate = self
        
        nameTextField.text = existingExpense?.name
        
        if let amount = existingExpense?.amount {
            amountTextField.text = "\(amount)"
        }
        // Do any additional setup after loading the view.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        nameTextField.resignFirstResponder()
        amountTextField.resignFirstResponder()
    }

    @IBAction func saveExpense(_ sender: Any) {
        let name = nameTextField.text
        let amountText = amountTextField.text ?? ""
        let amount = Double(amountText) ?? 0.0
        
        var expense: Expense?
        
        if let existingExpense = existingExpense {
            existingExpense.name = name
            existingExpense.amount = amount
            
            expense = existingExpense
        } else {
            expense = Expense(name: name, amount: amount)
        }
        
        if let expense = expense {
            do {
                let managedContext = expense.managedObjectContext
                
                try managedContext?.save()
                
                self.navigationController?.popViewController(animated: true)
            } catch {
                print("Context could not be saved")
            }
        }
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
