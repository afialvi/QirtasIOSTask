//
//  User.swift
//  Gatekeyper
//
//  Created by Qirtas on 17/12/2019.
//  Copyright © 2019 Qirtas. All rights reserved.
//

import Foundation
import CoreData

class User:Codable
{
    
    var id: Int = -1
    var username: String = ""
    var customer_id: Int? = -1
    var accessToken: String? = ""
    var password: String = ""
    var salt: String = ""
    var employee_id: Int? = -1
    var first_name: String = ""
    var last_name: String = ""
    var job_title: String = ""
    
    func saveToDB()
    {
           let userEntity = UserEntity(context: PersistenceService.context)
            userEntity.userId = String(self.id)
            userEntity.customerId = String(self.customer_id ?? -1)
            userEntity.accessToken = self.accessToken ?? ""
            userEntity.password = self.password
            userEntity.salt = self.salt
            userEntity.employeeId = String(self.employee_id ?? -1)
            userEntity.firstName = self.first_name
            userEntity.lastName = self.last_name
            userEntity.jobTitle = self.job_title
            userEntity.userName = self.username
        
           PersistenceService.saveContext()
           
    }
    
    func updateUserInDB(userName: String)
    {
        let predicate = NSPredicate(format: "userName = %@", userName)
        
        let sort = NSSortDescriptor(key: nil, ascending: true)
        let usersList:[UserEntity] = CoreDataStack.findByPredicate(predicate: predicate, managedObjectName: "UserEntity", sortDescriptor: sort) as! [UserEntity]
                
        if(usersList.count > 0)
        {
            var userEntity:UserEntity = usersList[usersList.count - 1]
            userEntity.accessToken = self.accessToken ?? ""
            userEntity.password = self.password
            userEntity.salt = self.salt
            userEntity.firstName = self.first_name
            userEntity.lastName = self.last_name
            userEntity.jobTitle = self.job_title
        }
        else
        {
            let userEntity = UserEntity(context: PersistenceService.context)
           userEntity.userId = String(self.id)
           userEntity.customerId = String(self.customer_id ?? -1)
           userEntity.accessToken = self.accessToken ?? ""
           userEntity.password = self.password
           userEntity.salt = self.salt
           userEntity.employeeId = String(self.employee_id ?? -1)
           userEntity.firstName = self.first_name
           userEntity.lastName = self.last_name
           userEntity.jobTitle = self.job_title
           userEntity.userName = self.username
        }
        
        PersistenceService.saveContext()
    }
    
    static func getUser(userName: String) -> [UserEntity]
    {
        let predicate = NSPredicate(format: "userName = %@", userName)
               
       let sort = NSSortDescriptor(key: nil, ascending: true)
       let usersList:[UserEntity] = CoreDataStack.findByPredicate(predicate: predicate, managedObjectName: "UserEntity", sortDescriptor: sort) as! [UserEntity]
        print("getUser count \(usersList.count)")
        
        return usersList
    }
    
    static func getAllUsers() -> [UserEntity]
       {
           let JTFetchReq: NSFetchRequest<UserEntity> = UserEntity.fetchRequest()
           
           do
           {
               let records = try PersistenceService.context.fetch(JTFetchReq)
               print("getAllUsers records count \(records.count)")
            
            for user in records
            {
                print("User name \(user.userName)   \(user.firstName)   \(user.password)")
            }
            
               
              return records
               
           } catch {}
           
           return [UserEntity]()
       }
    
}
