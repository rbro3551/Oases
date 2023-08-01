//
//  EditView.swift
//  Oases
//
//  Created by Riley Brookins on 7/2/23.
//

import SwiftUI

struct EditView: View {
    @StateObject private var viewModel: EditViewModel
    
    @Environment(\.dismiss) var dismiss
    var onSave: (Fountain) -> Void
    
    var body: some View {

        Form {
            Section {
                ZStack {
                    Rectangle()
                        .fill(.secondary)

                    
                    Text("Tap to select a picture")
                        .foregroundColor(.white)
                        .font(.headline)
                    
                    viewModel.image
                        .resizable()
                        .scaledToFit()
                }
                .frame(maxHeight: 300)
                .onTapGesture {
                    viewModel.showingImagePicker = true
                }


            }
            
            Section {
                TextField("Fountain name", text: $viewModel.name)
            } header: {
                Text("Fountain")
            }
            
            Section {
                RatingView(rating: $viewModel.rating)
                TextEditor(text: $viewModel.description)
                    .foregroundColor(viewModel.description == "Review" ? .gray : .primary)
                    .onTapGesture {
                        if viewModel.description == "Review" {
                            viewModel.description = ""
                        }
                    }
                    .frame(height: 100)
            } header: {
                Text("Review")
            }
        }
        .navigationTitle("Details")
        .toolbar {
            Button("Save") {
                
                onSave(viewModel.saveFountain())
                dismiss()
                
            }
        }
        .sheet(isPresented: $viewModel.showingImagePicker) {
            ImagePicker(image: $viewModel.inputImage)
        }
        .onChange(of: viewModel.inputImage) { _ in viewModel.loadImage() }
        
    }
    
    init(fountain: Fountain, onSave: @escaping (Fountain) -> Void) {
        _viewModel = StateObject(wrappedValue: EditViewModel(fountain: fountain))

        self.onSave = onSave
    }
}

struct EditView_Previews: PreviewProvider {
    static var previews: some View {
        EditView(fountain: Fountain.example) { _ in }
    }
}
