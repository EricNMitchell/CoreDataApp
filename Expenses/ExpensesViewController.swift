//
//  ExpensesViewController.swift
//  Expenses
//
//  Created by Eric Mitchell on 4/17/19.
//  Copyright © 2019 Eric Mitchell. All rights reserved.
//

import UIKit
import CoreData

class ExpensesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var expensesTableView: UITableView!
    
    var expenses = [Expense]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Expense> = Expense.fetchRequest()
        
        do {
            expenses = try managedContext.fetch(fetchRequest)
            
            expensesTableView.reloadData()
        } catch {
            print("Fetch could not be performed")
        }
        
    }
    
    @IBAction func addNewExpense(_ sender: Any) {
        performSegue(withIdentifier: "showExpense", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? SingleExpenseViewController,
            let selectedRow = self.expensesTableView.indexPathForSelectedRow?.row else {
                return
        }
        
        destination.existingExpense = expenses[selectedRow]
    }
    
    func deleteExpense(at indexPath: IndexPath){
        let expense = expenses[indexPath.row]
        
        if let managedContext = expense.managedObjectContext {
            managedContext.delete(expense)
            
            do {
                try managedContext.save()
                
                self.expenses.remove(at: indexPath.row)
                
                expensesTableView.deleteRows(at: [indexPath], with: .automatic)
            } catch {
                print("Delete failed")
                
                expensesTableView.reloadRows(at: [indexPath], with: .automatic)
            }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            deleteExpense(at: indexPath)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return expenses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "expenseCell", for: indexPath)
        let expense = expenses[indexPath.row]
        
        cell.textLabel?.text = expense.name
        
        cell.detailTextLabel?.text = String(expense.amount)
        
        return cell
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
