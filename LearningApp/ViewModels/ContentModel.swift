//
//  ContentModel.swift
//  LearningApp
//
//  Created by Michael Shustov on 22.07.2021.
//

import Foundation


class ContentModel: ObservableObject {
    
    @Published var modules = [Module]()
    
    @Published var currentModule: Module?
    
    var currentModuleIndex = 0
    
    @Published var currentLesson: Lesson?
    
    var currentLessonIndex = 0
    
    var styleData: Data?
    
    @Published var lessonDescription = NSAttributedString()
    
    @Published var currentContentSelected: Int?
    
    init() {
        
        getLocalData()
    }
    
    //MARK: Data methods
    
    func getLocalData() {
        
        let jsonUrl = Bundle.main.url(forResource: "data", withExtension: "json")
        
        do {
            
            let jsonData = try Data(contentsOf: jsonUrl!)
            
            let jsonDecoder = JSONDecoder()
            
            let modules = try jsonDecoder.decode([Module].self, from: jsonData)
            
            self.modules = modules
            
        }
        catch {
            
            print("Can't parse local data")
        }
        
        let styleUrl = Bundle.main.url(forResource: "style", withExtension: "html")
        
        do {
            
            let styleData = try Data(contentsOf: styleUrl!)
            
            self.styleData = styleData
        }
        catch {
            
            print("Can't parse style data")
        }
    }
    
    //MARK: Module navigation methods
    
    func beginModule(_ moduleId: Int) {
        
        for index in 0..<modules.count {
            
            if modules[index].id == index {
                
                currentModuleIndex = index
                break
            }
        }
        
        currentModule = modules[currentModuleIndex]
    }
    
    func beginLesson(_ lessonIndex: Int) {
        
        if lessonIndex < currentModule!.content.lessons.count {
            
            currentLessonIndex = lessonIndex
        }
        else {
            
            currentLessonIndex = 0
        }
        
        currentLesson = currentModule!.content.lessons[currentLessonIndex]
        
        lessonDescription = addStyling(currentLesson!.explanation)
    }
    
    func hasNextLesson() -> Bool {
        
        return (currentLessonIndex + 1 < currentModule!.content.lessons.count)
    }
    
    func nextLesson() {
        
        currentLessonIndex += 1
        
        if currentLessonIndex < currentModule!.content.lessons.count {
            
            currentLesson = currentModule!.content.lessons[currentLessonIndex]
            
            lessonDescription = addStyling(currentLesson!.explanation)
        }
        else {
            
            currentLessonIndex = 0
            
            currentLesson = nil
        }
    }
    
    // MARK: Code Styling
    
    private func addStyling(_ htmlString: String) -> NSAttributedString {
        
        var resultString = NSAttributedString()
        var data = Data()
        
        // Add style data
        if styleData != nil {
            
            data.append(styleData!)
            
        }
        
        // Add html data
        data.append(Data(htmlString.utf8))
        
        // Convert to attributed string
        // Approach 1
        //        do {
        //
        //            let attributedString = try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil)
        //
        //            resultString = attributedString
        //
        //        }
        //        catch {
        //
        //            print("Can't convert html to attributed string")
        //
        //        }
        
        //Approach 2
        if let attributedString = try? NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil) {
            
            resultString = attributedString
            
        }
        
        return resultString
        
    }
}
