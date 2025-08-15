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
        ZStack {
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .fill(Color(.systemBackground).opacity(0.95))
                .shadow(color: Color.black.opacity(0.07), radius: 10, x: 0, y: 4)
            VStack(spacing: 28) {
                ZStack {
                    Circle()
                        .fill(
                            LinearGradient(
                                gradient: Gradient(colors: [Color.blue.opacity(0.85), Color.purple.opacity(0.8)]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .frame(width: 80, height: 80)
                        .shadow(color: Color.blue.opacity(0.2), radius: 8, x: 0, y: 6)
                    Image(systemName: renderModel.iconName ?? "arrow.triangle.2.circlepath.circle")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 44, height: 44)
                        .foregroundColor(.white)
                        .shadow(color: Color.black.opacity(0.15), radius: 2, x: 0, y: 2)
                }
                Text(renderModel.text ?? "")
                    .font(.title2.weight(.semibold))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 4)
                Button(action: {
                    if let url = renderModel.url {
                        openURL(url)
                    }
                }) {
                    Text("Actualizar ahora")
                        .font(.headline.weight(.semibold))
                        .foregroundColor(.white)
                        .padding(.vertical, 14)
                        .frame(maxWidth: .infinity)
                        .background(
                            LinearGradient(
                                gradient: Gradient(colors: [Color.blue, Color.purple]),
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .cornerRadius(12)
                        .shadow(color: Color.purple.opacity(0.16), radius: 6, x: 0, y: 3)
                }
                .padding(.horizontal, 8)
            }
            .padding(.vertical, 32)
            .padding(.horizontal, 20)
        }
        .padding(.horizontal, 24)
        .transition(.opacity.combined(with: .scale))
    }
}
