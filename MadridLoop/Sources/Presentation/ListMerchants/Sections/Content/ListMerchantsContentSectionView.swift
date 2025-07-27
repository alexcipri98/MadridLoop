//
//  ListMerchantsContentSectionView.swift
//  MadridLoop
//
//  Created by Alex Ciprian lopez on 13/7/25.
//

import Combine
import PresentationLayer
import SwiftUI

struct ListMerchantsContentSectionView: ModularSection {

    typealias ViewModel = ListMerchantsContentSectionViewModelContract
    typealias RenderModel = ListMerchantsContentSectionRenderModel

    var viewModel: any ViewModel
    var publisher: AnyPublisher<RenderModel, Never>

    @State var renderModel: RenderModel = .hidden

    init(publisher: AnyPublisher<ListMerchantsContentSectionRenderModel, Never>,
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
        case .show(let merchants):
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    ForEach(merchants, id: \.id) { merchant in
                        VStack(alignment: .leading, spacing: 10) {
                            Text(merchant.title)
                                .font(.headline)
                                .foregroundColor(.primary)

                            Text(merchant.description)
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                            if let location = merchant.location {
                                Text(location)
                                    .font(.subheadline)
                                    .foregroundStyle(.secondary)
                            }

                            if let lat = merchant.latitude, let lon = merchant.longitude {
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

                            if let link = merchant.link, let url = URL(string: link) {
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
