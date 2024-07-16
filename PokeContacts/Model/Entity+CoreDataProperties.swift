//
//  Entity+CoreDataProperties.swift
//  PokeContacts
//
//  Created by ahnzihyeon on 7/16/24.
//
//

import Foundation
import CoreData


extension Entity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Entity> {
        return NSFetchRequest<Entity>(entityName: "Entity")
    }

    @NSManaged public var name: String?
    @NSManaged public var phoneNumber: String?
    @NSManaged public var image: String?

}

extension Entity : Identifiable {

}
