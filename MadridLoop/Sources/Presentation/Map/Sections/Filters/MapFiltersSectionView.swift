//
//  MapFiltersSectionView.swift
//  MadridLoop
//
//  Created by Alex Ciprian lopez on 13/7/25.
//

import Combine
import PresentationLayer
import SwiftUI

struct MapFiltersSectionView: ModularSection {
    
    typealias ViewModel = MapFiltersSectionViewModelContract
    typealias RenderModel = MapFiltersSectionRenderModel
    
    var viewModel: any ViewModel
    var publisher: AnyPublisher<RenderModel, Never>
    
    @State var renderModel: RenderModel = .hidden
    @State private var selectedDate: Date? = nil
    
    init(publisher: AnyPublisher<MapFiltersSectionRenderModel, Never>,
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
        case .show(let data):
            VStack {
                ScrollView(.horizontal) {
                    HStack(spacing: 16) {
                        ForEach(RenderModel.Filters.allCases, id: \.self) { filter in
                            if data.filters.contains(filter) {
                                switch filter {
                                case .date:
                                    CustomDatePicker(action: viewModel.didSelectDate,
                                                     selectedDate: $selectedDate)
                                case .trash:
                                    if let value = data.isFilterSelected[.isTrashFilterSelected] {
                                        trashFilterButton(isTrashFilterSelected: value)
                                    }
                                case .font:
                                    if let value = data.isFilterSelected[.isNormalFontsFilterSelected] {
                                        normalFontsFilterButton(isNormalFontFilterSelected: value)
                                    }
                                case .dogFont:
                                    if let value = data.isFilterSelected[.isDogsZonesFilterSelected] {
                                        dogsZonesFilterButton(isDogFontFilterSelected: value)
                                    }
                                case .park:
                                    EmptyView()
                                default:
                                    EmptyView()
                                }
                            }
                        }
                    }
                }
                .padding(16)
                .frame(maxWidth: .infinity, alignment: .topLeading)
                .background(Color.white.opacity(0.95))
                Spacer()
            }
            .frame(maxHeight: .infinity, alignment: .top)
        }
    }
    
    @ViewBuilder
    func trashFilterButton(isTrashFilterSelected: Bool) -> some View {
        Button(action: {
            viewModel.didToggleFilter(filter: .isTrashFilterSelected)
        }) {
            Image(systemName: IconsNames.trash.rawValue)
                .foregroundColor(isTrashFilterSelected ? .white : .orange)
                .padding()
                .background(RoundedRectangle(cornerRadius: 12).fill(isTrashFilterSelected ? Color.orange : Color.gray.opacity(0.2)))
        }
    }

    @ViewBuilder
    func normalFontsFilterButton(isNormalFontFilterSelected: Bool) -> some View {
        Button(action: {
            viewModel.didToggleFilter(filter: .isNormalFontsFilterSelected)
        }) {
            Image(systemName: IconsNames.normalFont.rawValue)
                .foregroundColor(isNormalFontFilterSelected ? .white : .orange)
                .padding()
                .background(RoundedRectangle(cornerRadius: 12).fill(isNormalFontFilterSelected ? Color.orange : Color.gray.opacity(0.2)))
        }
    }

    @ViewBuilder
    func dogsZonesFilterButton(isDogFontFilterSelected: Bool) -> some View {
        Button(action: {
            viewModel.didToggleFilter(filter: .isDogsZonesFilterSelected)
        }) {
            Image(systemName: IconsNames.dogFont.rawValue)
                .foregroundColor(isDogFontFilterSelected ? .white : .orange)
                .padding()
                .background(RoundedRectangle(cornerRadius: 12).fill(isDogFontFilterSelected ? Color.orange : Color.gray.opacity(0.2)))
        }
    }
}
