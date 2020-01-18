//
//  UserEntity+CoreDataProperties.swift
//  Gatekeyper
//
//  Created by Qirtas on 19/12/2019.
//  Copyright © 2019 Qirtas. All rights reserved.
//
//

import Foundation
import CoreData


extension UserEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserEntity> {
        return NSFetchRequest<UserEntity>(entityName: "UserEntity")
    }

    @NSManaged public var accessToken: String?
    @NSManaged public var customerId: String?
    @NSManaged public var employeeId: String?
    @NSManaged public var firstName: String?
    @NSManaged public var jobTitle: String?
    @NSManaged public var lastName: String?
    @NSManaged public var password: String?
    @NSManaged public var salt: String?
    @NSManaged public var userId: String?
    @NSManaged public var userName: String?

}
