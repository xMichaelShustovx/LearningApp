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
        
        NavigationView {
            
            VStack(alignment: .leading) {
                
                Text("What's for today?")
                    .padding(.leading, 20)
                
                ScrollView {
                    
                    LazyVStack {
                        
                        ForEach(model.modules) {module in
                            
                            VStack(spacing: 20) {
                                
                                NavigationLink(
                                    destination:
                                        ContentView()
                                        .onAppear(perform: {
                                            model.beginModule(module.id)
                                        }),
                                    tag: module.id,
                                    selection: $model.currentContentSelected,
                                    label: {
                                        
                                        // Learning card
                                        HomeViewRow(image: module.content.image, title: "Learn \(module.category)", description: module.content.description, count: "\(module.content.lessons.count) Lessons", time: module.content.time)
                                        
                                    })
                                
                                // Test card
                                
                                NavigationLink(
                                    destination:
                                        TestView()
                                        .onAppear(perform: {
                                                model.beginTest(module.id)                      
                                        }),
                                    tag: module.id,
                                    selection: $model.currentTestSelected,
                                    label: {
                                        
                                        HomeViewRow(image: module.test.image, title: "\(module.category) Test", description: module.test.description, count: "\(module.test.questions.count) Questions", time: module.test.time)
                                        
                                    })
                                
                                NavigationLink(destination: EmptyView()){
                                    EmptyView()
                                }
                            }
                            //.padding(.bottom, 20)
                        }
                    }
                    .accentColor(.black)
                    .padding()
                }
            }
            .navigationTitle("Get Started")
            .onChange(of: model.currentContentSelected) { changeValue in
                if changeValue == nil {
                    model.currentModule = nil
                }
            }
            .onChange(of: model.currentTestSelected) { changeValue in
                if changeValue == nil {
                    model.currentModule = nil
                }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(ContentModel())
    }
}
