//
//  newsspireApp.swift
//  newsspire
//
//  Created by Zayn on 10/14/21.
//

import SwiftUI

@main
struct newsspireApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
