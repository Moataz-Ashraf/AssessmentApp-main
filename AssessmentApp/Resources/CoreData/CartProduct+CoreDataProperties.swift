//
//  CartProduct+CoreDataProperties.swift
//  
//
//  Created by Moataz on 21/10/2022.
//
//

import Foundation
import CoreData


extension CartProduct {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CartProduct> {
        return NSFetchRequest<CartProduct>(entityName: "CartProduct")
    }

    @NSManaged public var name: String?
    @NSManaged public var imageURL: String?
    @NSManaged public var retailPrice: Double

}
