//
//  Fountain.swift
//  Oases
//
//  Created by Riley Brookins on 6/26/23.
//

import Foundation
import UIKit
import SwiftUI
import CoreLocation

struct Fountain: Identifiable, Equatable, Comparable, Codable, Hashable {
    var id = UUID()
    var image: Data
    var name: String
    var rating: Int
    var description: String
    let latitude: Double
    let longitude: Double
    var city: String
    
    
    // converts the image data into an image
    func convert() -> Image {
        let uiImageData = image
        if let uiImage = UIImage(data: uiImageData) {
            return Image(uiImage: uiImage)
        }
        return Image("example_fountain")
    }
    
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    static func <(lhs: Fountain, rhs: Fountain) -> Bool {
        lhs.name < rhs.name
    }
    
    static func == (lhs: Fountain, rhs: Fountain) -> Bool {
        lhs.name == rhs.name
    }
    

    
    static let exampleImage = UIImage(named: "Myimage")
    
    static let example = Fountain(image: Data(), name: "", rating: 3, description: "Review",  latitude: 0.0, longitude: 0.0, city: "--")
}
