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
    private let action: ((String) -> Void)?

    @State private var position = MapCameraPosition.region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 0, longitude: 0),
            span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        )
    )

    @State private var pressedMarkerID: String? = nil
    @State private var selectedGroup: [Location]? = nil

    public init(userLocation: CLLocationCoordinate2D?,
                places: [Location],
                action: ((String) -> Void)? = nil) {
        self.userLocation = userLocation
        self.places = places
        self.action = action
    }
    
    public var body: some View {
        let groupedPlaces = Dictionary(grouping: places) { location in
            "\(round(location.coordinate.latitude * 1e5)/1e5),\(round(location.coordinate.longitude * 1e5)/1e5)"
        }

        Map(position: $position) {
            UserAnnotation()
            ForEach(Array(groupedPlaces.values), id: \.first!.id) { group in
                if let coordinate = group.first?.coordinate {
                    Annotation("Evento", coordinate: coordinate) {
                        Button(action: {
                            if group.count == 1 {
                                action?(group[0].id)
                            } else {
                                selectedGroup = group
                            }
                        }) {
                            VStack {
                                if let iconName = group.first?.iconName, !iconName.isEmpty {
                                    Image(systemName: iconName)
                                        .foregroundColor(.red)
                                        .imageScale(.large)
                                } else {
                                    Image(systemName: "mappin.circle.fill")
                                        .foregroundColor(.red)
                                        .imageScale(.large)
                                }
                            }
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
            }
        }
        .overlay(
            Group {
                if let group = selectedGroup {
                    VStack(spacing: 12) {
                        ForEach(group.sorted(by: { ($0.startTime ?? .distantFuture) < ($1.startTime ?? .distantFuture) }), id: \.id) { location in
                            Button(action: {
                                action?(location.id)
                                selectedGroup = nil
                            }) {
                                HStack {
                                    if let icon = location.iconName {
                                        Image(systemName: icon)
                                    }
                                    Text(formattedDate(from: location.startTime))
                                }
                                .padding()
                                .background(Color.white)
                                .cornerRadius(8)
                                .shadow(radius: 4)
                            }
                        }
                        Button("Cerrar") {
                            selectedGroup = nil
                        }
                        .foregroundColor(.white)
                    }
                    .padding()
                    .background(Color.black.opacity(0.5))
                    .cornerRadius(12)
                }
            }
        )
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

    private func formattedDate(from date: Date?) -> String {
        guard let date = date else { return "Sin fecha" }
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}
