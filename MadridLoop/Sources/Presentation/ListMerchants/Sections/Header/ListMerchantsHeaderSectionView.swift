//
//  ListMerchantsHeaderSectionView.swift
//  MadridLoop
//
//  Created by Alex Ciprian lopez on 13/7/25.
//

import Combine
import PresentationLayer
import SwiftUI

struct ListMerchantsHeaderSectionView: ModularSection {

    typealias ViewModel = ListMerchantsHeaderSectionViewModelContract
    typealias RenderModel = ListMerchantsHeaderSectionRenderModel

    var viewModel: any ViewModel
    var publisher: AnyPublisher<RenderModel, Never>

    @State var renderModel: RenderModel = .hidden

    init(publisher: AnyPublisher<ListMerchantsHeaderSectionRenderModel, Never>,
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
            ZStack {
                Color.blue
                    .ignoresSafeArea()

                HStack {
                    Button(action: {
                        viewModel.goBack()
                    }) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.white)
                            .imageScale(.large)
                    }
                    .padding(.leading)

                    Spacer()
                }

                Text(title)
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding(.vertical)
            }.frame(height: 50)
        }
    }
}
