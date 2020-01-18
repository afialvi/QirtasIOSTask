//
//  ConfigEntity+CoreDataProperties.swift
//  Gatekeyper
//
//  Created by Qirtas on 17/12/2019.
//  Copyright © 2019 Qirtas. All rights reserved.
//
//

import Foundation
import CoreData


extension ConfigEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ConfigEntity> {
        return NSFetchRequest<ConfigEntity>(entityName: "ConfigEntity")
    }

    @NSManaged public var id: Int16
    @NSManaged public var no_of_failed_attempts: Int16
    @NSManaged public var operator_shift_hours: Int16
    @NSManaged public var password_type: String?
    @NSManaged public var password_validation: String?
    @NSManaged public var starter_unlock_seconds: Int16
    @NSManaged public var user_lock_minutes: Int16
    @NSManaged public var languages: NSSet?

}

// MARK: Generated accessors for languages
extension ConfigEntity {

    @objc(addLanguagesObject:)
    @NSManaged public func addToLanguages(_ value: LanguageEntity)

    @objc(removeLanguagesObject:)
    @NSManaged public func removeFromLanguages(_ value: LanguageEntity)

    @objc(addLanguages:)
    @NSManaged public func addToLanguages(_ values: NSSet)

    @objc(removeLanguages:)
    @NSManaged public func removeFromLanguages(_ values: NSSet)

}
