//
//  VersionUpdateContentSectionView.swift
//  MadridLoop
//
//  Created by Alex Ciprian lopez on 13/7/25.
//

import Combine
import PresentationLayer
import SwiftUI

struct VersionUpdateContentSectionView: ModularSection {

    typealias ViewModel = VersionUpdateContentSectionViewModelContract
    typealias RenderModel = VersionUpdateContentSectionRenderModel

    var viewModel: any ViewModel
    var publisher: AnyPublisher<RenderModel, Never>

    @State var renderModel: RenderModel = .empty()
    @Environment(\.openURL) var openURL

    init(publisher: AnyPublisher<VersionUpdateContentSectionRenderModel, Never>,
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
        VStack(spacing: 16) {
            Image(systemName: renderModel.iconName ?? "arrow.triangle.2.circlepath.circle")
                .resizable()
                .scaledToFit()
                .frame(width: 60, height: 60)
                .foregroundColor(.blue)
            
            Text(renderModel.text ?? "")
                .font(.headline)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            Button(action: {
                if let url = renderModel.url {
                    openURL(url)
                }
            }) {
                Text("Actualizar ahora")
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
    }
}
