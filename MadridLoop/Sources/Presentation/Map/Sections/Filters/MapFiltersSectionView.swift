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
                        datePicker(data: data)
                        if let valueTrash = data.isFilterSelected[.isTrashFilterSelected] {
                            trashFilterButton(isTrashFilterSelected: valueTrash)
                        }
                        if let valueNormalFont = data.isFilterSelected[.isNormalFontsFilterSelected] {
                            normalFontsFilterButton(isNormalFontFilterSelected: valueNormalFont)
                        }
                        if let valueDogFont = data.isFilterSelected[.isDogsFontsFilterSelected] {
                            dogsFontsFilterButton(isDogFontFilterSelected: valueDogFont)
                        }
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

    @ViewBuilder
    func datePicker(data: RenderModel.MapFiltersSectionRenderModelData) -> some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 100), spacing: 16)], spacing: 16) {
            ForEach(data.filters, id: \.self) { filter in
                DatePicker("",
                           selection: Binding(
                            get: {
                                selectedDate ?? Date()
                            },
                            set: {
                                selectedDate = $0
                                viewModel.didSelectDate(date: $0)
                            }
                           ),
                           displayedComponents: [.date]
                )
                .labelsHidden()
                .datePickerStyle(.compact)
                .frame(maxWidth: .infinity)
                .background(RoundedRectangle(cornerRadius: 12).fill(Color.orange.opacity(0.9)))
            }
        }
        .padding(.horizontal)
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
    func dogsFontsFilterButton(isDogFontFilterSelected: Bool) -> some View {
        Button(action: {
            viewModel.didToggleFilter(filter: .isDogsFontsFilterSelected)
        }) {
            Image(systemName: IconsNames.dogFont.rawValue)
                .foregroundColor(isDogFontFilterSelected ? .white : .orange)
                .padding()
                .background(RoundedRectangle(cornerRadius: 12).fill(isDogFontFilterSelected ? Color.orange : Color.gray.opacity(0.2)))
        }
    }
}
