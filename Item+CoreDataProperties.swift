//
//  Item+CoreDataProperties.swift
//  TodoList
//
//  Created by AgribankCard on 2/26/17.
//  Copyright © 2017 cuongpc. All rights reserved.
//

import Foundation
import CoreData


extension Item {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Item> {
        return NSFetchRequest<Item>(entityName: "Item");
    }

    @NSManaged public var name: String?

}
