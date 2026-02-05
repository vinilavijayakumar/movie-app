//
//  TheMovieList_VinilaApp.swift
//  TheMovieList_Vinila
//
//  Created by Vinila Vijayakumar on 04/02/2026.
//

import SwiftUI
import CoreData

@main
struct TheMovieList_VinilaApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            MovieListView()
//            ContentView()
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
