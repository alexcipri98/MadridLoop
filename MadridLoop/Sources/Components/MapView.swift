//
//  MapView.swift
//  MadridLoop
//
//  Created by Alex Ciprian lopez on 14/7/25.
//

import Combine
import PresentationLayer
import SwiftUI
import MapKit
import Foundation
import CoreLocation

public struct MapView: View {
    private let userLocation: CLLocationCoordinate2D?
    private let places: [Location]
    private let iconName: String?
    private let action: ((String) -> Void)?

    @State private var position = MapCameraPosition.region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 0, longitude: 0),
            span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        )
    )

    @State private var pressedMarkerID: String? = nil

    public init(userLocation: CLLocationCoordinate2D?,
                places: [Location],
                iconName: String? = "",
                action: ((String) -> Void)? = nil) {
        self.userLocation = userLocation
        self.places = places
        self.iconName = iconName
        self.action = action
    }
    
    public var body: some View {
        Map(position: $position) {
            UserAnnotation()
            ForEach(places) { location in
                Annotation("Evento", coordinate: location.coordinate) {
                    Button(action: {
                        pressedMarkerID = location.id
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                            pressedMarkerID = nil
                        }
                        action?(location.id)
                    }) {
                        VStack {
                            if let iconName = iconName, !iconName.isEmpty {
                                Image(systemName: iconName)
                                    .foregroundColor(pressedMarkerID == location.id ? .blue : .red)
                                    .imageScale(.large)
                            } else {
                                Image(systemName: "mappin.circle.fill")
                                    .foregroundColor(pressedMarkerID == location.id ? .blue : .red)
                                    .imageScale(.large)
                            }
                        }
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
        }
        .onAppear {
            position = .region(
                MKCoordinateRegion(
                    center: userLocation ?? CLLocationCoordinate2D(latitude: 40.4168, longitude: -3.7038),
                    span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
                )
            )
        }
        .ignoresSafeArea()
    }
}
