//
//  InformationMapModalContentSectionView.swift
//  MadridLoop
//
//  Created by Alex Ciprian lopez on 13/7/25.
//

import Combine
import PresentationLayer
import SwiftUI
import WebKit

struct InformationMapModalContentSectionView: ModularSection {

    typealias ViewModel = InformationMapModalContentSectionViewModelContract
    typealias RenderModel = InformationMapModalContentSectionRenderModel

    var viewModel: any ViewModel
    var publisher: AnyPublisher<RenderModel, Never>

    @State var renderModel: RenderModel = .hidden
    @State private var showWebView = false
    @State private var webViewHeight: CGFloat = 0

    init(publisher: AnyPublisher<InformationMapModalContentSectionRenderModel, Never>,
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
        case .show(let content):
            VStack(alignment: .leading, spacing: 24) {
                if let title = content.title {
                    Text(title)
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding(.bottom, 4)
                }

                if let description = content.description {
                    Text(description)
                        .font(.body)
                }

                if let formatted = getFormattedStartTime(startTime: content.startTime) {
                    HStack {
                        Image(systemName: "calendar")
                        Text(formatted)
                    }
                    .font(.subheadline)
                    .foregroundColor(.gray)
                }

                if let schedule = content.schedule {
                    HStack {
                        Image(systemName: "calendar")
                        Text(schedule)
                    }
                    .font(.subheadline)
                    .foregroundColor(.gray)
                }

                if let location = content.location {
                    Button(action: {
                        viewModel.howToGoTapped()
                    }) {
                        Label("Cómo llegar", systemImage: "map")
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .padding(.top, 16)
                }

                if let link = content.link,
                   let url = URL(string: link) {
                    HStack {
                        Image(systemName: "link")
                            .foregroundColor(.blue)
                        Link("Ver más", destination: url)
                            .font(.subheadline)
                            .foregroundColor(.blue)
                    }
                }
                Spacer()
            }
            .padding()
        }
    }

    func getFormattedStartTime(startTime: String?) -> String? {
        guard let date = startTime?.parseStringToDate() else { return nil }
        let outputFormatter = DateFormatter()
        outputFormatter.dateStyle = .medium
        outputFormatter.timeStyle = .short
        return outputFormatter.string(from: date)
    }
}
