//
//  AddView-ViewModel.swift
//  Oases
//
//  Created by Riley Brookins on 6/28/23.
//

import Foundation
import CoreImage
import SwiftUI
import CoreLocation


extension AddView {
    @MainActor class AddViewModel: ObservableObject {
        var fountain: Fountain
        
        
        @Published var name: String
        @Published var rating: Int
        @Published var description: String
        @Published var image: Image?
        @Published var inputImage: UIImage?
        @Published var showingImagePicker = false
        @Published var isLoading: Bool = false
        
        
        // initial fountain name, rating, and description
        init(fountain: Fountain) {
            name = fountain.name
            rating = fountain.rating
            description = fountain.description
            self.fountain = fountain
        }
        
        // saves the newly added fountain
        func saveFountain() async -> Fountain {
            
            isLoading = true
            var newFountain = fountain
            newFountain.id = UUID()
            newFountain.name = name
            newFountain.rating = rating
            newFountain.description = description
            newFountain.image = inputImage?.jpegData(compressionQuality: 0.2) ?? Data()
            newFountain.city = await cityManager(latitude: fountain.latitude, longitude: fountain.longitude)
            isLoading = false
            
            
            return newFountain
        }
        
        // converts a uiImage into a SwiftUI image
        func loadImage() {
            guard let inputImage = inputImage else { return }
            image = Image(uiImage: inputImage)
        }
        
        func cityManager(latitude: Double, longitude: Double) async -> String {
            var text: String = ""
            let geoCoder = CLGeocoder()
            let location = CLLocation(latitude: latitude, longitude: longitude)
            if let city = try? await geoCoder.reverseGeocodeLocation(location)
                .first
                .flatMap({ placemark in
                    placemark.locality
                })
            {
                text = city
            } else {
                text = "--"
            }
            
            return text
        }
        
    }
}
