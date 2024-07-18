//
//  Entity+CoreDataClass.swift
//  PokeContacts
//
//  Created by ahnzihyeon on 7/16/24.
//
//

import Foundation
import CoreData

@objc(PhoneBook)
public class PhoneBook: NSManagedObject {
    public static let className = "PhoneBook"
       public enum Key {
           static let name = "name"
           static let phoneNumber = "phoneNumber"
           static let image = "image"
       }
}
