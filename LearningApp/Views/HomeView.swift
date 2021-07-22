//
//  ContentView.swift
//  LearningApp
//
//  Created by Michael Shustov on 22.07.2021.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var model: ContentModel
    
    var body: some View {
        
        Text(String(model.modules[0].id))
            .padding()
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(ContentModel())
    }
}
