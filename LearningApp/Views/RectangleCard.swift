//
//  RectangleCard.swift
//  LearningApp
//
//  Created by Michael Shustov on 24.07.2021.
//

import SwiftUI

struct RectangleCard: View {
    
    var color = Color.white
    
    var body: some View {

        Rectangle()
            .foregroundColor(color)
            .cornerRadius(10)
            .shadow(radius: 5)
        
    }
}
