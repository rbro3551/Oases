//
//  ProfileView.swift
//  Oases
//
//  Created by Riley Brookins on 7/5/23.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var fountains: Fountains
    @StateObject var viewModel = ProfileViewModel()
    
    
    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    RankView(progress: viewModel.determineProgress(reviews: fountains.reviews()), color: viewModel.determineColor(reviews: fountains.reviews()))
                        .frame(width: 300, height: 300)
                        .navigationTitle("Reviewer Rank")
                    
                    viewModel.determineMessage(reviews: fountains.reviews())
                        .font(.title)
                        .foregroundColor(.secondary)
                }
                
                Text(Int(fountains.reviews()) >= viewModel.maxReviews ? "You're an expert!" : "^[\(viewModel.determineRemaining(reviews: fountains.reviews())) more reviews](inflect: true) until the next level!")
                    .padding()
                    .foregroundColor(.secondary)
            }
        }
    }
    
    
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
            .environmentObject(Fountains())
    }
}
