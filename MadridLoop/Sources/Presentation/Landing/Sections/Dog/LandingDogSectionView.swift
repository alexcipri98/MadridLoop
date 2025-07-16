//
//  LandingDogSectionView.swift
//  MadridLoop
//
//  Created by Alex Ciprian lopez on 13/7/25.
//

import Combine
import PresentationLayer
import SwiftUI

struct LandingDogSectionView: ModularSection {

    typealias ViewModel = LandingDogSectionViewModelContract
    typealias RenderModel = LandingDogSectionRenderModel

    var viewModel: any ViewModel
    var publisher: AnyPublisher<RenderModel, Never>

    @State var renderModel: RenderModel = .hidden

    init(publisher: AnyPublisher<LandingDogSectionRenderModel, Never>,
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
            Button(action: {
                viewModel.lookInMapDogsTapped()
            }) {
                HStack(spacing: 12) {
                    Image(systemName: data.icon)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 100)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(12)
                    VStack(alignment: .leading, spacing:12) {
                        Text(data.title)
                            .font(.headline)
                            .foregroundColor(.primary)
                            .padding(.horizontal)
                        
                        Text(data.description)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .padding(.horizontal)
                            .padding(.bottom)
                    }
                }
                .background(Color(.systemGray6))
                .cornerRadius(16)
                .shadow(radius: 2)
                .padding(.horizontal)
            }
            .buttonStyle(PlainButtonStyle())
        }
    }
}
