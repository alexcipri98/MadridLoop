//
//  ListEventsFiltersSectionView.swift
//  MadridLoop
//
//  Created by Alex Ciprian lopez on 13/7/25.
//

import Combine
import PresentationLayer
import SwiftUI

struct ListEventsFiltersSectionView: ModularSection {
    
    typealias ViewModel = ListEventsFiltersSectionViewModelContract
    typealias RenderModel = ListEventsFiltersSectionRenderModel
    
    var viewModel: any ViewModel
    var publisher: AnyPublisher<RenderModel, Never>
    
    @State var renderModel: RenderModel = .hidden
    @State private var selectedDate: Date? = nil
    
    init(publisher: AnyPublisher<ListEventsFiltersSectionRenderModel, Never>,
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
        case .error:
            EmptyView()
        case .show:
            VStack {
                ScrollView(.horizontal) {
                    HStack(spacing: 16) {
                        CustomDatePicker(action: viewModel.didSelectDate,
                                         selectedDate: $selectedDate)
                    }
                }
                .padding(.vertical, 16)
                .frame(maxWidth: .infinity, alignment: .topLeading)
                .background(Color.white.opacity(0.95))
                Spacer()
            }
            .frame(maxHeight: .infinity, alignment: .top)
        }
    }
}
