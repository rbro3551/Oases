//
//  EditView-ViewModel.swift
//  Oases
//
//  Created by Riley Brookins on 7/2/23.
//

import Foundation
import CoreImage
import SwiftUI

extension EditView {
    @MainActor class EditViewModel: ObservableObject {
        var fountain: Fountain
        
        @Published var name: String
        @Published var rating: Int
        @Published var description: String
        @Published var image: Image
        @Published var inputImage: UIImage?
        @Published var showingImagePicker = false
        
        
        // initializes the name, rating, description, and the image for the fountain
        init(fountain: Fountain) {
            name = fountain.name
            rating = fountain.rating
            description = fountain.description
            image = fountain.convert()
            self.fountain = fountain
        }
        
        // saves changes that the user made to an existing fountain
        func saveFountain() -> Fountain {
            var newFountain = fountain
            newFountain.id = UUID()
            newFountain.name = name
            newFountain.rating = rating
            newFountain.description = description
            newFountain.image = inputImage?.jpegData(compressionQuality: 0.2) ?? fountain.image
            newFountain.city = fountain.city
            
            return newFountain
        }
        
        // converts a UiImage to a SwiftUI image
        func loadImage() {
            guard let inputImage = inputImage else { return }
            image = Image(uiImage: inputImage)
        }
        
    }
}
