//
//  LocationPermissionContentSectionView.swift
//  MadridLoop
//
//  Created by Alex Ciprian lopez on 13/7/25.
//

import Combine
import PresentationLayer
import SwiftUI

struct LocationPermissionContentSectionView: ModularSection {

    typealias ViewModel = LocationPermissionContentSectionViewModelContract
    typealias RenderModel = LocationPermissionContentSectionRenderModel

    var viewModel: any ViewModel
    var publisher: AnyPublisher<RenderModel, Never>

    @State var renderModel: RenderModel = .empty()
    @Environment(\.openURL) var openURL

    init(publisher: AnyPublisher<LocationPermissionContentSectionRenderModel, Never>,
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
        VStack(spacing: 24) {
            ZStack {
                Circle()
                    .fill(
                        LinearGradient(
                            gradient: Gradient(colors: [Color.blue.opacity(0.2), Color.blue.opacity(0.05)]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: 90, height: 90)
                    .shadow(color: Color.blue.opacity(0.18), radius: 8, x: 0, y: 4)
                Image(systemName: renderModel.iconName ?? "arrow.triangle.2.circlepath.circle")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 48, height: 48)
                    .foregroundColor(.blue)
            }
            Text(renderModel.text ?? "")
                .font(.title2.weight(.semibold))
                .multilineTextAlignment(.center)
                .padding(.horizontal, 18)
                .padding(.vertical, 6)
            Button(action: {
                viewModel.goToSettings()
            }) {
                Text("Conceder permisos")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(
                        LinearGradient(
                            gradient: Gradient(colors: [Color.blue, Color.purple]),
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .cornerRadius(12)
                    .shadow(color: Color.blue.opacity(0.13), radius: 5, x: 0, y: 2)
            }
            .padding(.horizontal)
        }
        .padding(28)
        .background(
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .fill(Color(.systemBackground).opacity(0.97))
                .shadow(color: Color.black.opacity(0.07), radius: 20, x: 0, y: 8)
        )
        .padding(.horizontal, 24)
        .padding(.vertical, 10)
        .transition(.opacity.combined(with: .scale))
    }
}
