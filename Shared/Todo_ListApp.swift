//
//  Todo_ListApp.swift
//  Shared
//
//  Created by Yunior's Mac on 2021 - 08 - 10.
//

import SwiftUI

@main
struct Todo_ListApp: App {
    let persistentContainer = CoreDataManager.shared.persistentContainer
  
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext,persistentContainer.viewContext)
        }
    }
}
