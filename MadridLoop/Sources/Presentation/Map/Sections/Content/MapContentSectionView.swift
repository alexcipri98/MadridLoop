//
//  MapContentSectionView.swift
//  MadridLoop
//
//  Created by Alex Ciprian lopez on 13/7/25.
//

import Combine
import PresentationLayer
import SwiftUI

struct MapContentSectionView: ModularSection {

    typealias ViewModel = MapContentSectionViewModelContract
    typealias RenderModel = MapContentSectionRenderModel

    var viewModel: any ViewModel
    var publisher: AnyPublisher<RenderModel, Never>

    @State var renderModel: RenderModel = .hidden

    init(publisher: AnyPublisher<MapContentSectionRenderModel, Never>,
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
        case .error:
            VStack(spacing: 16) {
                Text("No podemos acceder a tu ubicación.")
                    .font(.body)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)

                Button(action: {
                    viewModel.openSettings()
                }) {
                    Text("Abrir Ajustes")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .padding(.horizontal)
            }
            .padding()
            
        case .show(let data):
            MapView(userLocation: data.userLocation,
                    places: data.places,
                    action: data.action)
        }
    }
}
