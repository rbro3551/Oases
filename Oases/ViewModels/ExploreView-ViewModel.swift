//
//  ExploreView-ViewModel.swift
//  Oases
//
//  Created by Riley Brookins on 6/28/23.
//

import Foundation
import MapKit
import SwiftUI

extension ExploreView {
    class ViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
        
        
        // wrapped region from https://stackoverflow.com/questions/67864517/how-to-properly-put-2000-custom-annotations-on-swiftui-mapview-to-keep-lag-t
        
        var _region: MKCoordinateRegion = MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 38.6270, longitude: -90.1994),
            span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1))

        var region: Binding<MKCoordinateRegion> {
            Binding(
                get: { self._region },
                set: { self._region = $0 }
            )
        }

//        @Published var flag = false
        
//        @Published var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 38.6270, longitude: -90.1994), span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1))
        
        @Published var showingAddSheet = false
        @Published var selectedPlace: Fountain?
        
        var locationManager: CLLocationManager?
        
        
        // initializes a new fountain on the map
        func addFountain() -> Fountain {
            objectWillChange.send()
            let newFountain = Fountain(image: Data(), name: "New Fountain", rating: 0, description: "Review", latitude: region.wrappedValue.center.latitude, longitude: region.wrappedValue.center.longitude, city: "--")
            return newFountain
        }
        
        
        // checks if location services is enabled before creating a location manager
        func checkIfLocationServicesIsEnabled() {
            self.locationManager = CLLocationManager()
            self.locationManager!.delegate = self
        }
        
        // checks for the type of authorization the user provides for their location
        func checkLocationAuthorization() {
            guard let locationManager = locationManager else { return }
            
            switch locationManager.authorizationStatus {
                
            case .notDetermined:
                locationManager.requestWhenInUseAuthorization()
            case .restricted:
                print("Your location is restricted  likely due to parental controls.")
            case .denied:
                print("Go in to settings to change location permission")
            case .authorizedAlways, .authorizedWhenInUse:
                objectWillChange.send()
                updateRegion(newRegion: MKCoordinateRegion(center: locationManager.location!.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)))
            @unknown default:
                break
            }
        }
        
        // automatic delegate function that runs when authorization has changed
        func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
            checkLocationAuthorization()
        }
        
        func updateRegion(newRegion: MKCoordinateRegion) {
            Task { @MainActor in
                withAnimation {
                    region.wrappedValue = newRegion
                    objectWillChange.send()
                }
            }
        }
        
        
    }
}
