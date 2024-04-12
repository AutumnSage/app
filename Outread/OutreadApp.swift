//
//  OutreadApp.swift
//  Outread
//
//  Created by Dhruv Sirohi on 17/1/2024.
//

import SwiftUI
import SwiftData

@main
struct OutreadApp: App {
    @StateObject var bookmarkManager = BookmarkManager()
    @State private var products: [Product] = []
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
            .environmentObject(bookmarkManager)
        }
        .modelContainer(sharedModelContainer)
    }
    init() {
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().isTranslucent = true
    }
}
