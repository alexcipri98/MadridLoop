//
//  GenericErrorSectionView.swift
//  MadridLoop
//
//  Created by Alex Ciprian lopez on 13/7/25.
//

import Combine
import PresentationLayer
import SwiftUI

struct GenericErrorSectionView: ModularSection {

    typealias ViewModel = GenericErrorSectionViewModelContract
    typealias RenderModel = GenericErrorSectionRenderModel

    var viewModel: any ViewModel
    var publisher: AnyPublisher<RenderModel, Never>

    @State var renderModel: RenderModel = .hidden

    init(publisher: AnyPublisher<GenericErrorSectionRenderModel, Never>,
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
        case .show(let data):
            VStack(spacing: 16) {
                Image(systemName: data.icon)
                    .resizable()
                    .frame(width: 48, height: 48)
                    .foregroundColor(.yellow)

                Text(data.title)
                    .font(.title)
                    .fontWeight(.bold)

                Text(data.description)
                    .font(.body)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.secondary)

                Button(action: {
                    viewModel.tryAgain()
                }) {
                    Text(data.buttonText)
                        .fontWeight(.semibold)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .padding(.top, 8)
                .padding(.horizontal)
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(.systemBackground))
        }
    }
}
