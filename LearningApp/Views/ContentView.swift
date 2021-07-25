//
//  ContentView.swift
//  LearningApp
//
//  Created by Michael Shustov on 23.07.2021.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var model: ContentModel
    
    var body: some View {

        ScrollView {
            
            LazyVStack {
                
                if model.currentModule != nil {
                 
                    ForEach(0..<model.currentModule!.content.lessons.count) { index in
                        
                        NavigationLink(
                            destination:
                            ContentDetailView()
                                .onAppear(perform: {
                                    model.beginLesson(index)
                                }),
                            label: {
                                
                                ContentViewRow(index: index)
                            })
                    }
                }
            }
            .accentColor(.black)
            .padding()
            .navigationBarTitle("Learn \(model.currentModule?.category ?? "")")
        }
    }
}
