//
//  DetailItem+CoreDataProperties.swift
//  TodoList
//
//  Created by AgribankCard on 3/1/17.
//  Copyright © 2017 cuongpc. All rights reserved.
//

import Foundation
import CoreData


extension DetailItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DetailItem> {
        return NSFetchRequest<DetailItem>(entityName: "DetailItem");
    }

    @NSManaged public var nameDetail: String?
    @NSManaged public var item: Item?

}
