//
//  TestView.swift
//  LearningApp
//
//  Created by Michael Shustov on 25.07.2021.
//

import SwiftUI

struct TestView: View {
    
    @EnvironmentObject var model: ContentModel
    
    @State var selectedAnswerIndex: Int?
    
    @State var numCorrect = 0
    
    @State var submitted = false
    
    var body: some View {
        
        if model.currentQuestion != nil {
            
            VStack(alignment: .leading) {
                
                Text("Question \(model.currentQuestionIndex + 1) of \(model.currentModule?.test.questions.count ?? 0)")
                    .padding(.leading, 20)
                
                CodeTextView()
                    .padding(.horizontal, 20)
                
                ScrollView {
                    
                    VStack {
                        
                        ForEach(0..<model.currentQuestion!.answers.count, id: \.self) { index in
                            
                            Button(
                                action: {
                                    selectedAnswerIndex = index
                                },
                                label: {
                                    
                                    ZStack {
                                        
                                        if submitted == false {
                                            RectangleCard(color: index == selectedAnswerIndex ? .gray : .white)
                                                .frame(height: 48)
                                        }
                                        else {
                                            
                                            if (index == selectedAnswerIndex && index == model.currentQuestion!.correctIndex) || index == model.currentQuestion!.correctIndex {
                                                
                                                RectangleCard(color: Color.green)
                                                    .frame(height: 48)
                                                
                                            }
                                            else if index == selectedAnswerIndex {
                                                
                                                RectangleCard(color: Color.red)
                                                    .frame(height: 48)
                                                
                                            }
                                            else {
                                                
                                                RectangleCard(color: Color.white)
                                                    .frame(height: 48)
                                                
                                            }
                                        }
                                        
                                        Text(model.currentQuestion!.answers[index])
                                        
                                    }
                                })
                                .disabled(submitted)
                        }
                    }
                    .accentColor(.black)
                    .padding()
                }
                
                Button {
                    
                    if submitted {
                        
                        model.nextQuestion()
                        
                        submitted = false
                        
                        selectedAnswerIndex = nil
                        
                    }
                    else {
                        submitted = true
                        
                        if selectedAnswerIndex == model.currentQuestion!.correctIndex{
                            numCorrect += 1
                        }
                    }
                    
                } label: {
                    
                    ZStack {
                        RectangleCard(color: .green)
                            .frame(height: 48)
                        
                        Text(buttonText)
                            .bold()
                            .foregroundColor(.white)
                    }
                    .padding()
                }
                .disabled(selectedAnswerIndex == nil)
                
            }
            .navigationBarTitle("\(model.currentModule?.category ?? "") Test")
        }
        else {
            
            TestResultView(numCorrect: numCorrect)
            
        }
    }
    
    var buttonText: String {
        
        if submitted {
            
            if model.currentQuestionIndex == model.currentModule!.test.questions.count - 1 {
                
                return "Finish Test"
                
            }
            else {
             
                return "Next"
                
            }
        }
        else {
            
            return "Submit"
            
        }
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
