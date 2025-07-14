//
//  LandingHeaderSectionView.swift
//  MadridLoop
//
//  Created by Alex Ciprian lopez on 13/7/25.
//

import Combine
import PresentationLayer
import SwiftUI

struct LandingHeaderSectionView: ModularSection {

    typealias ViewModel = LandingHeaderSectionViewModelContract
    typealias RenderModel = LandingHeaderSectionRenderModel

    var viewModel: any ViewModel
    var publisher: AnyPublisher<RenderModel, Never>

    @State var renderModel: RenderModel = .hidden

    init(publisher: AnyPublisher<LandingHeaderSectionRenderModel, Never>,
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
