//
//  Fountains.swift
//  Oases
//
//  Created by Riley Brookins on 6/26/23.
//

import Foundation


class Fountains: ObservableObject {
    let savePathOases = FileManager.documentsDirectory.appendingPathComponent("SavedFountains")
    
    @Published var items = [Fountain]() {
        didSet {
            
            do {
                let encoder = JSONEncoder()
                
                let encoded = try encoder.encode(items)
                try encoded.write(to: savePathOases, options: [.atomic, .completeFileProtection])
                
                
            } catch {
                print("Saving failed")
            }
            
            
        }
    }
    
    init() {
        do {
            let fountainsData = try Data(contentsOf: savePathOases)
            items = try JSONDecoder().decode([Fountain].self, from: fountainsData)
        } catch {
            items = []
        }
    }
    
    // returns the amount of reviewed fountains a user has
    func reviews() -> Double {
        Double(items.count)
    }
    
    func save() {
        do {
            let encoder = JSONEncoder()
            
            let encoded = try encoder.encode(items)
            try encoded.write(to: savePathOases, options: [.atomic, .completeFileProtection])
            
            
        } catch {
            print("Saving failed")
        }
    }
}
