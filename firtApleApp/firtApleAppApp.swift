//
//  firtApleAppApp.swift
//  firtApleApp
//
//  Created by shegida on 28.04.2022.
//

import SwiftUI

@main
struct firtApleAppApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
