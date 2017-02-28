//
//  Item+CoreDataProperties.swift
//  TodoList
//
//  Created by AgribankCard on 3/1/17.
//  Copyright © 2017 cuongpc. All rights reserved.
//

import Foundation
import CoreData


extension Item {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Item> {
        return NSFetchRequest<Item>(entityName: "Item");
    }

    @NSManaged public var name: String?
    @NSManaged public var detailItems: NSOrderedSet?

}

// MARK: Generated accessors for detailItems
extension Item {

    @objc(insertObject:inDetailItemsAtIndex:)
    @NSManaged public func insertIntoDetailItems(_ value: DetailItem, at idx: Int)

    @objc(removeObjectFromDetailItemsAtIndex:)
    @NSManaged public func removeFromDetailItems(at idx: Int)

    @objc(insertDetailItems:atIndexes:)
    @NSManaged public func insertIntoDetailItems(_ values: [DetailItem], at indexes: NSIndexSet)

    @objc(removeDetailItemsAtIndexes:)
    @NSManaged public func removeFromDetailItems(at indexes: NSIndexSet)

    @objc(replaceObjectInDetailItemsAtIndex:withObject:)
    @NSManaged public func replaceDetailItems(at idx: Int, with value: DetailItem)

    @objc(replaceDetailItemsAtIndexes:withDetailItems:)
    @NSManaged public func replaceDetailItems(at indexes: NSIndexSet, with values: [DetailItem])

    @objc(addDetailItemsObject:)
    @NSManaged public func addToDetailItems(_ value: DetailItem)

    @objc(removeDetailItemsObject:)
    @NSManaged public func removeFromDetailItems(_ value: DetailItem)

    @objc(addDetailItems:)
    @NSManaged public func addToDetailItems(_ values: NSOrderedSet)

    @objc(removeDetailItems:)
    @NSManaged public func removeFromDetailItems(_ values: NSOrderedSet)

}
