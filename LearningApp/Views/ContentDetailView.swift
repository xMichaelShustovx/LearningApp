//
//  ContentDetailView.swift
//  LearningApp
//
//  Created by Michael Shustov on 23.07.2021.
//

import SwiftUI
import AVKit

struct ContentDetailView: View {
    
    @EnvironmentObject var model: ContentModel
    
    var body: some View {
        
        let lesson = model.currentLesson
        let url = URL(string: Constants.videoHostUrl + (lesson?.video ?? ""))
        
        VStack {
            
            //Video
            if url != nil {
                
                VideoPlayer(player: AVPlayer(url: url!))
                    .cornerRadius(10)
            }
            
            //Description
            CodeTextView()
            
            //Next video button
            if model.hasNextLesson() {
                
                Button(action: {
                    
                    model.nextLesson()
                    
                }, label: {
                    
                    ZStack {
                        
                        RectangleCard(color: Color.green)
                            .frame(height: 48)
                        
                        Text("Next Lesson: \(model.currentModule!.content.lessons[model.currentLessonIndex + 1].title)")
                            .bold()
                            .foregroundColor(.white)
                    }
                })
            }
            else {
                
                Button(action: {
                    
                    model.currentContentSelected = nil
                    
                }, label: {
                    
                    ZStack {
                        
                        RectangleCard(color: Color.green)
                            .frame(height: 48)
                        
                        Text("Complete")
                            .bold()
                            .foregroundColor(.white)
                    }
                })
            }
        }
        .padding()
        .navigationBarTitle(lesson?.title ?? "")
    }
}

struct ContentDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ContentDetailView()
    }
}
