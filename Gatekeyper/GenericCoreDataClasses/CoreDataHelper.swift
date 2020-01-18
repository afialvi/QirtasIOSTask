//
//  CoreDataHelper.swift
//  Gatekeyper
//
//  Created by Muhammad Alvi on 16/01/2020.
//  Copyright © 2020 Qirtas. All rights reserved.
//

import UIKit
import CoreData

class CoreDataHelper: NSObject {
    func savePath(title: String, pathOfFile: String) {
      
      guard let appDelegate =
        UIApplication.shared.delegate as? AppDelegate else {
        return
      }
      
      // 1
      let managedContext =
        appDelegate.persistentContainer.viewContext
      
      // 2
      let entity =
        NSEntityDescription.entity(forEntityName: "StoragePath",
                                   in: managedContext)!
      
      let storagePath = NSManagedObject(entity: entity,
                                   insertInto: managedContext)
      
      // 3
      storagePath.setValue(pathOfFile, forKeyPath: "path")
        storagePath.setValue(title, forKey: "title")
      
      // 4
      do {
        try managedContext.save()
        
      } catch let error as NSError {
        print("Could not save. \(error), \(error.userInfo)")
      }
    }
    
    
    func getPaths() -> [NSManagedObject]?{
        var paths : [NSManagedObject]?
        guard let appDelegate =
           UIApplication.shared.delegate as? AppDelegate else {
             return nil
         }
         
         let managedContext =
           appDelegate.persistentContainer.viewContext
         
         //2
         let fetchRequest =
           NSFetchRequest<NSManagedObject>(entityName: "StoragePath")
         
         //3
         do {
           paths = try managedContext.fetch(fetchRequest)
         } catch let error as NSError {
           print("Could not fetch. \(error), \(error.userInfo)")
         }
        return paths
    }
    
    
    func getVideoUrl(title: String) -> NSManagedObject?{
        var paths : [NSManagedObject]?
        guard let appDelegate =
           UIApplication.shared.delegate as? AppDelegate else {
             return nil
         }
         
         let managedContext =
           appDelegate.persistentContainer.viewContext
         
         //2
         let fetchRequest =
           NSFetchRequest<NSManagedObject>(entityName: "StoragePath")
         
         //3
         do {
           paths = try managedContext.fetch(fetchRequest)
            if(paths != nil){
                for path in paths!{
                    let ttl = path.value(forKey: "title")
                    let ttlStr = ttl == nil ? "" : ttl as! String
                    if(ttlStr == title){
                        return path
                    }
                   
                }
            }
         } catch let error as NSError {
           print("Could not fetch. \(error), \(error.userInfo)")
         }
        return nil
    }
    func deleteAllPaths(){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "StoragePath")
        fetchRequest.returnsObjectsAsFaults = false

        do {
            let arrUsrObj = try managedContext.fetch(fetchRequest)
            for usrObj in arrUsrObj as! [NSManagedObject] {
                managedContext.delete(usrObj)
            }
           try managedContext.save() //don't forget
            } catch let error as NSError {
            print("delete fail--",error)
          }

    }
    
}
