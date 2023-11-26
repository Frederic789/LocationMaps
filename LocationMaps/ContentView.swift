//
//  ContentView.swift
//  LocationMaps
//
//  Created by Student Account on 11/25/23.
//

import SwiftUI
import MapKit

struct ContentView: View {
    let locationManager = CLLocationManager()
    @State var message = "Map of University of Washington Bothell and Cascadia College"
    
    // Region centered around University of Washington Bothell
    @State private var region: MKCoordinateRegion = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 47.7589, longitude: -122.1907),
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    )

    // Define an identifiable structure for places
    struct IdentifiablePlace: Identifiable {
        let id: UUID
        let location: CLLocationCoordinate2D
        init(id: UUID = UUID(), lat: Double, long: Double) {
            self.id = id
            self.location = CLLocationCoordinate2D(latitude: lat, longitude: long)
        }
    }

    // Location of University of Washington Bothell
    let uwBothell = IdentifiablePlace(lat: 47.7589, long: -122.1907)
    // Location of Cascadia College
    let cascadiaCollege = IdentifiablePlace(lat: 47.7603, long: -122.1905)

    var body: some View {
        VStack {
            Map(coordinateRegion: $region,
                annotationItems: [uwBothell, cascadiaCollege]) { place in
                    MapMarker(coordinate: place.location, tint: .blue)
                }
            TextEditor(text: $message)
                .frame(width: .infinity, height: 100)
        }
        .onAppear {
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.distanceFilter = kCLDistanceFilterNone
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
