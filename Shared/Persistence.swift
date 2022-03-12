//
//  Persistence.swift
//  Shared
//
//  Created by Yunior's Mac on 2021 - 08 - 10.
//
import Foundation
import CoreData

struct CoreDataManager {
    let persistentContainer: NSPersistentContainer
    static let shared : CoreDataManager=CoreDataManager()
    
    private init(){
        persistentContainer=NSPersistentContainer(name: "TodoModel")
        persistentContainer.loadPersistentStores{
            description,error in
            if let error = error{
                fatalError("Unable to initialize Core Data \(error)")
            }
        }
    }
   
}
