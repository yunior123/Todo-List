//
//  Todo_ListApp.swift
//  Shared
//
//  Created by Yunior's Mac on 2021 - 08 - 10.
//

import SwiftUI

@main
struct Todo_ListApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
