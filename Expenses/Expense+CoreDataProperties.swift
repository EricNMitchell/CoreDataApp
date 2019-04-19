//
//  Expense+CoreDataProperties.swift
//  Expenses
//
//  Created by Eric Mitchell on 4/18/19.
//  Copyright © 2019 Eric Mitchell. All rights reserved.
//
//

import Foundation
import CoreData


extension Expense {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Expense> {
        return NSFetchRequest<Expense>(entityName: "Expense")
    }

    @NSManaged public var name: String?
    @NSManaged public var amount: Double

}
