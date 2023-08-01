//
//  FountainsView-ViewModel.swift
//  Oases
//
//  Created by Riley Brookins on 7/9/23.
//

import Foundation
import CoreLocation

extension FountainsView {
    @MainActor class FountainsViewModel: ObservableObject {
        enum FilterType {
            case none, name
        }
        
        @Published var filter: FilterType
        
        @Published var searchText = ""
        
        @Published var showingFilterSheet = false
        
        
        init(filter: FilterType, searchText: String) {
            self.filter = .none
        }
        
        func filteredFountains(fountains: [Fountain]) -> [Fountain] {
            if searchText.isEmpty {
                switch filter {
                case .none:
                    return fountains
                case .name:
                    return fountains.sorted { $1.name > $0.name }
                }
            } else {
                return fountains.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
            }
        }
        

        

    }
}
