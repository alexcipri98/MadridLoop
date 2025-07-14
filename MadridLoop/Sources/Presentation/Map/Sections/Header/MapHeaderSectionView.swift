//
//  MapHeaderSectionView.swift
//  MadridLoop
//
//  Created by Alex Ciprian lopez on 13/7/25.
//

import Combine
import PresentationLayer
import SwiftUI

struct MapHeaderSectionView: ModularSection {

    typealias ViewModel = MapHeaderSectionViewModelContract
    typealias RenderModel = MapHeaderSectionRenderModel

    var viewModel: any ViewModel
    var publisher: AnyPublisher<RenderModel, Never>

    @State var renderModel: RenderModel = .hidden

    init(publisher: AnyPublisher<MapHeaderSectionRenderModel, Never>,
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
        case .show(let title):
            HStack {
                Button("< Atras") {
                    viewModel.goBack()
                }.foregroundColor(.white)
                Spacer()
                Text(title)
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding(.vertical)
                Spacer()
            }.background(Color.blue)
                .ignoresSafeArea()
        }
    }
}
