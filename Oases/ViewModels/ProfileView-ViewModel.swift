//
//  ProfileView-ViewModel.swift
//  Oases
//
//  Created by Riley Brookins on 7/5/23.
//

import Foundation
import SwiftUI

extension ProfileView {
    class ProfileViewModel: ObservableObject {
        enum Levels {
            case pinkLevel, blueLevel, purpleLevel
        }
        
        let maxReviews = 25
        
        
        // determines the current ranking the user is at
        func determineLevel(reviews: Double) -> Levels {
            if reviews >= 25 {
                return .purpleLevel
            }
            
            else if reviews >= 10 {
                return .blueLevel
            } else {
                return .pinkLevel
            }
        }
        
        // determines the color of the progress bar
        func determineColor(reviews: Double) -> Color {
            switch determineLevel(reviews: reviews) {
            case .blueLevel: return Color.blue
            case .purpleLevel: return Color.purple
            default: return Color.pink
                
            }
        }
        
        // determines the current goal of the user to reach the next rank
        func determineGoal(reviews: Double) -> Double {
            switch determineLevel(reviews: reviews) {
            case .pinkLevel: return 10
            case .blueLevel: return 15
            default: return 0
            }
        }
        
        
        // determines how much the user has progressed in their current rank
        func determineProgress(reviews: Double) -> Double {
            switch determineLevel(reviews: reviews) {
            case .pinkLevel: return reviews / determineGoal(reviews: reviews)
            case .blueLevel: return (reviews - 10.0) / determineGoal(reviews: reviews)
            default: return 1.0
            }
        }
        
        // determines how many reviews the user has left for the current rank
        func determineRemaining(reviews: Double) -> Int {
            switch determineLevel(reviews: reviews) {
            case .pinkLevel: return 10 - Int(reviews)
            case.blueLevel: return 25 - Int(reviews)
            default: return 0
            }
        }
        
        // determines the rank name
        func determineMessage(reviews: Double) -> Text {
            switch determineLevel(reviews: reviews) {
            case .pinkLevel: return Text("\"Beginner\"")
            case .blueLevel: return Text("\"Tasteful\"")
            case .purpleLevel: return Text("\"Connesieur\"")
            }
        }
    }
}
