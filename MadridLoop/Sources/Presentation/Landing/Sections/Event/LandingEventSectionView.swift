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
            EmptyView()
        case .show(let entries):
            HStack {
                Spacer()
                Button("Ver en mapa") {
                    viewModel.lookInMapEventsTapped()
                }
                .font(.footnote)
                .padding(.trailing, 16)
                .padding(.top, 10)
            }
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(entries.indices, id: \.self) { index in
                        entryView(entries[index])
                    }
                }
                .padding(.horizontal)
                .padding(.vertical, 10)
            }
        }
    }

    @ViewBuilder
    func entryView(_ event: RenderModel.LandingEventDataRenderModel) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(event.title)
                .font(.headline)
                .fontWeight(.semibold)
                .foregroundColor(.white)
                .lineLimit(2)
            if let location = event.location {
                Text(location)
                    .font(.subheadline)
                    .foregroundColor(.white.opacity(0.85))
                    .lineLimit(1)
            }

            Text("Inicio: \(event.dateStart)")
                .font(.caption)
                .foregroundColor(.white.opacity(0.7))

            Spacer()

            if let link = event.link, let url = URL(string: link) {
                Link("Ver más", destination: url)
                    .font(.footnote)
                    .foregroundColor(.blue)
                    .padding(.top, 4)
            }
        }
        .padding()
        .frame(width: 260, height: 150)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(LinearGradient(
                    gradient: Gradient(colors: [.indigo, .purple]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                ))
        )
        .shadow(color: .black.opacity(0.15), radius: 4, x: 0, y: 3)
    }
}
