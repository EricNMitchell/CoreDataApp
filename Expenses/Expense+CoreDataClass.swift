//
//  Expense+CoreDataClass.swift
//  Expenses
//
//  Created by Eric Mitchell on 4/18/19.
//  Copyright © 2019 Eric Mitchell. All rights reserved.
//
//

import UIKit
import CoreData

@objc(Expense)
public class Expense: NSManagedObject {

    convenience init?(name: String?, amount: Double) {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {
            return nil
        }
        
        self.init(entity: Expense.entity(), insertInto: managedContext)
        
        self.name = name
        self.amount = amount
    }
}
