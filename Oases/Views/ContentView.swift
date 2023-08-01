//
//  ContentView.swift
//  Oases
//
//  Created by Riley Brookins on 6/26/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var fountains = Fountains()
    
    var body: some View {
        TabView {
            FountainsView()
                .tabItem {
                    Label("Fountains", systemImage: "drop")

                }
            
            ExploreView()
                .tabItem {
                    Label("Explore", systemImage: "map")
                }
            
            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person.crop.circle")
                }
        }
        .environmentObject(fountains)
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
