//
//  ListEventsContentSectionView.swift
//  MadridLoop
//
//  Created by Alex Ciprian lopez on 13/7/25.
//

import Combine
import PresentationLayer
import SwiftUI

struct ListEventsContentSectionView: ModularSection {

    typealias ViewModel = ListEventsContentSectionViewModelContract
    typealias RenderModel = ListEventsContentSectionRenderModel

    var viewModel: any ViewModel
    var publisher: AnyPublisher<RenderModel, Never>

    @State var renderModel: RenderModel = .hidden

    init(publisher: AnyPublisher<ListEventsContentSectionRenderModel, Never>,
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
        case .show(let events):
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    ForEach(events, id: \.id) { event in
                        VStack(alignment: .leading, spacing: 10) {
                            Text(event.title)
                                .font(.headline)
                                .foregroundColor(.primary)

                            Text("Inicio: \(event.dateStart)")
                                .font(.subheadline)
                                .foregroundColor(.secondary)

                            if let endDate = event.dateEnd {
                                Text("Fin: \(endDate)")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }

                            if let location = event.location {
                                Text("Lugar: \(location)")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }

                            if let lat = event.latitude, let lon = event.longitude {
                                Button(action: {
                                    viewModel.howToGoTapped(lat: lat, lon: lon)
                                }) {
                                    Label("Cómo llegar", systemImage: "map")
                                        .font(.headline)
                                        .frame(maxWidth: .infinity)
                                        .padding()
                                        .background(Color.blue)
                                        .foregroundColor(.white)
                                        .cornerRadius(10)
                                }
                                .padding(.top, 16)
                            }

                            if let link = event.link, let url = URL(string: link) {
                                Link("Ver más", destination: url)
                                    .font(.footnote.weight(.semibold))
                                    .foregroundColor(.accentColor)
                                    .padding(.top, 4)
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
                .padding(.vertical)
            }
        }
    }
}
