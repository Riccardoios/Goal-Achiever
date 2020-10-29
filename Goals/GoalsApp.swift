//
//  GoalsApp.swift
//  Goals
//
//  Created by Riccardo Carlotto on 28/10/2020.
//

import SwiftUI

@main
struct GoalsApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            Home()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(TimerViewModel())
        }
    }
}
