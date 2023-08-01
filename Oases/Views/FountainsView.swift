//
//  FountainsView.swift
//  Oases
//
//  Created by Riley Brookins on 6/26/23.
//

import SwiftUI

struct FountainsView: View {
    @EnvironmentObject var fountains: Fountains
    @StateObject var viewModel = FountainsViewModel(filter: .none, searchText: "")
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.filteredFountains(fountains: fountains.items.reversed())) { fountain in
                    NavigationLink {
                        EditView(fountain: fountain) { newFountain in
                            if let index = fountains.items.firstIndex(of: fountain) {
                                fountains.items[index] = newFountain
                            }
                        }

                    } label: {
                        HStack {
                            fountain.convert()
                                .resizable()
                                .frame(width: 44, height: 44)
                                .clipShape(Circle())
                                .overlay(
                                    RoundedRectangle(cornerRadius: 50)
                                        .stroke(Color.black, lineWidth: 2)
                                )
                            
                            VStack(alignment: .leading) {
                                Text(fountain.name)
                                Text(fountain.city)
                                    .foregroundColor(.secondary)
                                    .font(.footnote)
                                    
                                
                            }
                            Spacer()
                            EmojiRatingView(rating: Int16(fountain.rating))
                        }
                    }
                    .swipeActions {
                        Button(role: .destructive) {
                            removeRows(fountain: fountain)
                        } label: {
                            Text("Delete")
                                .foregroundColor(Color.red)
                        }
                    }
                    
                }

            }
            .overlay(Group {
                if fountains.items.isEmpty {
                    Text("This is where fountains you've added from \"Explore\" will show up")
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.bottom, 100)
                }
            })
            .navigationTitle("Fountains")
            .searchable(text: $viewModel.searchText, prompt: "Search for a fountain")
            .toolbar {
                Button("Sort") {
                    viewModel.showingFilterSheet = true
                }
            }
            .confirmationDialog("Select a filter", isPresented: $viewModel.showingFilterSheet) {
                Button("Default") {
                    viewModel.filter = .none
                }
                Button("Name") {
                    viewModel.filter = .name
                }
                
            }
        }
    }
    
    func removeRows(fountain: Fountain) {
        if let i = fountains.items.firstIndex(where: {$0.id == fountain.id} ) {
            fountains.items.remove(at: i)
        }
    }
}

struct FountainsView_Previews: PreviewProvider {
    static var previews: some View {
        FountainsView()
            .environmentObject(Fountains())
    }
}
