//
//  LearningApp.swift
//  LearningApp
//
//  Created by Michael Shustov on 22.07.2021.
//

import SwiftUI

@main
struct LearningApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(ContentModel())
        }
    }
}
