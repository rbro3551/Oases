//
//  AddView.swift
//  Oases
//
//  Created by Riley Brookins on 6/28/23.
//

import SwiftUI

struct AddView: View {
    @StateObject private var viewModel: AddViewModel
    @Environment(\.dismiss) var dismiss
    var onSave: (Fountain) -> Void
    var onDismiss: ((Bool) -> Void)? = nil
    
    var body: some View {
        NavigationView {
            ZStack {
                Form {
                    Section {
                        ZStack {
                            if viewModel.image == nil {
                                Rectangle()
                                    .fill(.ultraThinMaterial)
                                    .clipShape(RoundedRectangle(cornerRadius: 25.0))
                                
                                
                                Text("Tap to select a picture")
                                    .foregroundColor(.secondary)
                                    .font(.headline)
                            }
                            
                            viewModel.image?
                                .resizable()
                                .scaledToFit()
                        }
                        .frame(height: 300)
                        .onTapGesture {
                            viewModel.showingImagePicker = true
                        }


                    }
                    Section {
                        TextField("Fountain name", text: $viewModel.name)
                    } header: {
                        Text("Fountain Name")
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
                        Text("Leave a review")
                    }
                }
                .opacity(viewModel.isLoading ? 0.5 : 1.0)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button("Cancel") {
                            onDismiss?(true)
                            dismiss()
                        }
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("Save") {
                            Task {
                                await onSave(viewModel.saveFountain())
                                dismiss()
                            }
                        }
                    }
                }
                .navigationTitle("Add a fountain")
                .sheet(isPresented: $viewModel.showingImagePicker) {
                    ImagePicker(image: $viewModel.inputImage)
                }
                .onChange(of: viewModel.inputImage) { _ in viewModel.loadImage() }
                
            .interactiveDismissDisabled()
                
                if viewModel.isLoading {
                    LoadingView()
                        .offset(y: -55)
                }
            }
            .allowsHitTesting(viewModel.isLoading ? false : true)
        }
    }
    
    init(fountain: Fountain, onSave: @escaping (Fountain) -> Void, onDismiss: ((Bool) -> Void)?) {
        _viewModel = StateObject(wrappedValue: AddViewModel(fountain: fountain))
        
        self.onSave = onSave
        self.onDismiss = onDismiss
        
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(fountain: Fountain.example, onSave: { _ in }) { _ in }
    }
}
                              
