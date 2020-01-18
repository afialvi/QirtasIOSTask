//
//  CoreDataStack.swift
//  Gatekeyper
//
//  Created by Qirtas on 17/12/2019.
//  Copyright © 2019 Qirtas. All rights reserved.
//

import Foundation
import CoreData

class CoreDataStack: NSObject
{
    static var coreDataStack: CoreDataStack?
      
      static func getInstance() -> CoreDataStack{
          if(coreDataStack == nil){
              coreDataStack = CoreDataStack()
          }
          return coreDataStack!
      }
    
    static func findByPredicate(predicate: NSPredicate, managedObjectName: String, sortDescriptor: NSSortDescriptor) -> [NSManagedObject]{
           let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: managedObjectName)
           fetchRequest.predicate = predicate;
           
           if(sortDescriptor.key != nil)
           {
               fetchRequest.sortDescriptors = [sortDescriptor]
           }
           
           let results =
               try! PersistenceService.context.fetch(fetchRequest)
           let managedObjects = results as! [NSManagedObject]
           return managedObjects;
       }
    
    static func deleteAllRecords(entityName: String)
    {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try PersistenceService.context.execute(deleteRequest)
        } catch let error as NSError {
            // TODO: handle the error
        }
        
    }
}
