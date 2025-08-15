//
//  LocationPermissionScreen.swift
//  MadridLoop
//
//  Created by Alex Ciprian lopez on 13/7/25.
//

import Combine
import SwiftUI

public struct LocationPermissionScreen<Top: View, Content: View, Bottom: View, Overlay: View>: View {
    private let content: Content
    private let top: Top
    private let bottom: Bottom
    private let overlay: Overlay
    private let viewModel: LocationPermissionViewModelContract

    @State private var viewSize: CGSize = .zero
    @Environment(\.scenePhase) private var scenePhase

    public init(viewModel: LocationPermissionViewModelContract,
                @ViewBuilder top: () -> Top,
                @ViewBuilder content: () -> Content,
                @ViewBuilder bottom: () -> Bottom,
                @ViewBuilder overlay: () -> Overlay){
        self.content = content()
        self.top = top()
        self.bottom = bottom()
        self.overlay = overlay()
        self.viewModel = viewModel
    }

    public var body: some View {
        ZStack(alignment: .bottom) {
            BackgroundView()
            VStack(spacing: 0) {
                top
                Spacer()
                ZStack {
                    content
                    overlay
                }
                Spacer()
            }
        }
        .onChange(of: scenePhase) {
            if scenePhase == .active {
                viewModel.notifyAppearance()
            }
        }
    }
}

private extension LocationPermissionScreen {
    struct BackgroundView: View {
        var body: some View {
            Color.white.ignoresSafeArea(.all)
        }
    }
}

