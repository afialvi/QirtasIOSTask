//
//  CustomerConfigModel.swift
//  Gatekeyper
//
//  Created by Qirtas on 17/12/2019.
//  Copyright © 2019 Qirtas. All rights reserved.
//

import Foundation
import CoreData

class CustomerConfigModel:Codable
{
    var id:Int16 = 0
    var no_of_failed_attempts:Int16 = 3
    var operator_shift_hours:Int16 = 16
    var password_type:String?
    var password_validation:String?
    var starter_unlock_seconds:Int16 = 60
    var user_lock_minutes:Int16 = 2
    
    var languages:[LanguageModel]?
    
    init(id:Int16, no_of_failed_attempts:Int16, operator_shift_hours:Int16, password_type:String, password_validation:String, starter_unlock_seconds:Int16, user_lock_minutes:Int16) {
        self.id = id
        self.no_of_failed_attempts = no_of_failed_attempts
        self.operator_shift_hours = operator_shift_hours
        self.password_type = password_type
        self.password_validation = password_validation
        self.starter_unlock_seconds = starter_unlock_seconds
        self.user_lock_minutes = user_lock_minutes
    }
    
    func saveToDB()
    {
        let config = ConfigEntity(context: PersistenceService.context)
        config.id = self.id
        config.no_of_failed_attempts = self.no_of_failed_attempts
        config.operator_shift_hours = self.operator_shift_hours
        config.password_type = self.password_type
        config.password_validation = self.password_validation
        config.starter_unlock_seconds = self.starter_unlock_seconds
        config.user_lock_minutes = self.user_lock_minutes
        
        for lang in self.languages!
        {
            let language = LanguageEntity(context: PersistenceService.context)
            language.id = lang.id
            language.name = lang.language_name
            config.addToLanguages(language)
        }
        
        PersistenceService.saveContext()
        
    }

}
