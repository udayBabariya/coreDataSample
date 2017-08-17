//
//  Person+CoreDataProperties.swift
//  Core data sample
//
//  Created by uday on 8/17/17.
//  Copyright © 2017 uday. All rights reserved.
//

import Foundation
import CoreData


extension Person {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Person> {
        return NSFetchRequest<Person>(entityName: "Person")
    }

    @NSManaged public var name: String?
    @NSManaged public var age: Int16

}
