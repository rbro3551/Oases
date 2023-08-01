//
//  ExploreView.swift
//  Oases
//
//  Created by Riley Brookins on 6/26/23.
//

import SwiftUI
import MapKit
import CoreLocationUI

struct ExploreView: View {
    @EnvironmentObject var fountains: Fountains
    @StateObject private var viewModel = ViewModel()
    

    
    
    var body: some View {
        ZStack {
            Map(coordinateRegion: viewModel.region, showsUserLocation: true, annotationItems: fountains.items) { fountian in
                MapAnnotation(coordinate: fountian.coordinate) {
                    VStack {
                        fountian.convert()
                            .resizable()
                            .frame(width: 44, height: 44)
                            .clipShape(Circle())
                            .overlay(
                                RoundedRectangle(cornerRadius: 50)
                                    .stroke(Color.black, lineWidth: 2)
                            )
                    }
                    .onTapGesture {
                        viewModel.selectedPlace = fountian
                    }
                }
            }
            .ignoresSafeArea(.container, edges: .top)
            .onAppear {

            }
            
            Circle()
                .fill(.gray)
                .opacity(0.4)
                .frame(width: 32, height: 32)
            
            VStack {
                Spacer()
                
                HStack {
                    Spacer()
                    
                    Button {
                        
                        viewModel.checkIfLocationServicesIsEnabled()
                        
                    } label: {
                        Image(systemName: "location")
                            .frame(width: 25, height: 25)
                            .padding()
                            .background(.black.opacity(0.75))
                            .foregroundColor(.white)
                            .font(.title)
                            .clipShape(Circle())
                            .padding(.trailing)
                            
                    }

                }
                
                HStack {
                    Spacer()
                    
                    Button {
                        
                        fountains.items.append(viewModel.addFountain())
                        viewModel.showingAddSheet = true

                        

                        
                    } label: {
                        Image(systemName: "plus")
                            .frame(width: 25, height: 25)
                            .padding()
                            .background(.black.opacity(0.75))
                            .foregroundColor(.white)
                            .font(.title)
                            .clipShape(Circle())
                            .padding([.trailing, .bottom])
                    }

                }
            }
        }
        .sheet(isPresented: $viewModel.showingAddSheet) {
            AddView(fountain: fountains.items[fountains.items.count - 1],
                    onSave: { newFountain in
                fountains.items[fountains.items.count - 1] = newFountain
            }) { dismiss in
                if dismiss {
                    fountains.items.removeLast()
                }
            }
        }
        
        .sheet(item: $viewModel.selectedPlace) { place in
            NavigationView {
                EditView(fountain: place) { newFountain in
                    if let index = fountains.items.firstIndex(of: viewModel.selectedPlace ?? Fountain.example) {
                        fountains.items[index] = newFountain
                    }
                    fountains.save()
                }
            }
        }
    }
}

struct ExploreView_Previews: PreviewProvider {
    static var previews: some View {
        ExploreView()
            .environmentObject(Fountains())
    }
}
