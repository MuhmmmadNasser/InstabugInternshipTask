//
//  InstabugLogger.swift
//  InstabugLogger
//
//  Created by Yosef Hamza on 19/04/2021.
//

import Foundation
import CoreData

public class InstabugLogger {
    public static var shared = InstabugLogger()
    
    //3.//Your framework bundle ID
    let identifier: String = "com.Instabug.InstabugLogger"
    
    //Model name
    let model: String = "CoreDataModel"
    
    lazy var persistentContainer: NSPersistentContainer = {
        let messageKitBundle = Bundle(identifier: self.identifier)
        let modelURL = messageKitBundle!.url(forResource: self.model, withExtension: "momd")!
        let managedObjectModel =  NSManagedObjectModel(contentsOf: modelURL)
        
        let container = NSPersistentContainer(name: self.model, managedObjectModel: managedObjectModel!)
        container.loadPersistentStores { (storeDescription, error) in
            if let err = error{
                fatalError("❌ Loading of store failed:\(err)")
            }
        }
        
        return container
        
    }()
    
    // MARK: Logging
    #warning("Implement the following")
    public func log(_ level: Int, message: String) {
        //fatalError("Not implemented")
        let context = persistentContainer.viewContext
        let contact = NSEntityDescription.insertNewObject(forEntityName: "Logger", into: context) as! Logger
        let fetchRequest = NSFetchRequest<Logger>(entityName: "Logger")
        
        contact.message = message
        contact.level = Int32(level)
        
        do {
            var logs = try context.fetch(fetchRequest)
            
            for (index,log) in logs.enumerated() {
                if index > 5{
                    logs.removeLast()
                  
                    logs.append(log)
                    //context.delete(log)
                    //context.insert(log)
                    
                }
                /*
                if log.message!.count > 5 {
                    log.message = "\(log.message)..."

                }*/
             }
            
            try context.save()
            //print("✅ Person saved succesfuly")
            
        } catch let error {
            print("❌ Failed to create Person: \(error.localizedDescription)")
        }
    }
    
    // MARK: Fetch logs
    #warning("Implement the following")
    public func fetchAllLogs() -> Any {
        
        let context = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<Logger>(entityName: "Logger")
        
        do{
            let logs = try context.fetch(fetchRequest)
            
            for (index,log) in logs.enumerated() {
                
                print("Logging \(index): \(log.message ?? "N/A ")  ALevel: \(log.level )")
                return log
            }
        }catch let fetchErr {
            print("❌ Failed to fetch Person:",fetchErr)
        }
        fatalError("Not implemented")
    }
    
    
    #warning("Implement the following")
    public func fetchAllLogs(completionHandler: (Any)->Void) {
        //fatalError("Not implemented")
        let context = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<Logger>(entityName: "Logger")
        
        do{
            let logs = try context.fetch(fetchRequest)
            
            for (index,log) in logs.enumerated() {
                
                completionHandler("Logging \(index): \(log.message ?? "N/A") ALevel:\(log.level )")
                //print("Logging \(index): \(log.message ?? "N/A")  ALevel:\(log.level )")
            }
        }catch let fetchErr {
            print("❌ Failed to fetch Person:",fetchErr)
        }
        //fatalError("Not implemented")
        //return 0
    }

}

