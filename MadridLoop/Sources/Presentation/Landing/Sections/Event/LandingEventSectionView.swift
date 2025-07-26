//
//  LandingEventSectionView.swift
//  MadridLoop
//
//  Created by Alex Ciprian lopez on 13/7/25.
//

import Combine
import PresentationLayer
import SwiftUI
import MapKit
import Foundation
import CoreLocation

struct LandingEventSectionView: ModularSection {

    typealias ViewModel = LandingEventSectionViewModelContract
    typealias RenderModel = LandingEventSectionRenderModel

    var viewModel: any ViewModel
    var publisher: AnyPublisher<RenderModel, Never>

    @State var renderModel: RenderModel = .hidden

    init(publisher: AnyPublisher<LandingEventSectionRenderModel, Never>,
         viewModel: any ViewModel) {
        self.viewModel = viewModel
        self.publisher = publisher
    }

    var body: some View {
        main
            .onReceive(publisher) {
                renderModel = $0
            }
    }

    @ViewBuilder
    var main: some View {
        switch renderModel {
        case .hidden:
            LoadingView()
        case .show(let entries):
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    Text("Eventos")
                        .font(.title2)
                        .fontWeight(.bold)
                    Spacer()
                    Button(action: {
                        viewModel.lookInListEventsTapped()
                    }) {
                        Text("Ver listado")
                            .font(.subheadline)
                            .foregroundColor(.accentColor)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 6)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.accentColor, lineWidth: 1)
                            )
                    }.padding(.trailing, 12)
                    Button(action: {
                        viewModel.lookInMapEventsTapped()
                    }) {
                        Text("Ver mapa")
                            .font(.subheadline)
                            .foregroundColor(.accentColor)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 6)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.accentColor, lineWidth: 1)
                            )
                    }
                }
                Text("Descubre los eventos disponibles en Madrid.")
                    .font(.body)
                    .foregroundColor(.secondary)
                    .fixedSize(horizontal: false, vertical: true)

                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 16) {
                        ForEach(entries.indices, id: \.self) { index in
                            entryView(entries[index])
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top, 8)
                }
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color(UIColor.secondarySystemBackground))
            )
            .padding(.horizontal)
        }
    }

    func entryView(_ event: RenderModel.LandingEventDataRenderModel) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(event.title)
                .font(.headline)
                .fontWeight(.bold)
                .foregroundColor(.primary)
                .lineLimit(3)
                .fixedSize(horizontal: false, vertical: true)

            if let location = event.location {
                Label(location, systemImage: "mappin.and.ellipse")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .lineLimit(1)
            }

            Text("Inicio: \(formattedDate(event.dateStart))")
                .font(.footnote)
                .foregroundColor(.secondary)
            if let date = event.dateEnd {
                Text("Fin: \(formattedDate(date))")
                    .font(.footnote)
                    .foregroundColor(.secondary)
            }
            Spacer()
            
            if let link = event.link, let url = URL(string: link) {
                Link("Ver más", destination: url)
                    .font(.footnote.weight(.semibold))
                    .foregroundColor(.accentColor)
            }
        }
        .padding()
        .frame(width: 260, height: 180)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(UIColor.systemBackground))
                .shadow(color: .black.opacity(0.05), radius: 4, x: 0, y: 2)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.gray.opacity(0.1), lineWidth: 0.5)
        )
    }
    
    private func formattedDate(_ dateString: String) -> String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss.S"
        inputFormatter.locale = Locale(identifier: "en_US_POSIX")
        
        if let date = inputFormatter.date(from: dateString) {
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = "dd-MM-yyyy HH:mm"
            return outputFormatter.string(from: date)
        }
        
        return dateString
    }
}
