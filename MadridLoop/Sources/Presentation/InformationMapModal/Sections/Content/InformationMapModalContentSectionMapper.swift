//
//  InformationMapModalContentSectionMapper.swift
//  MadridLoop
//
//  Created by Alex Ciprian lopez on 13/7/25.
//

import Combine
import PresentationLayer

public protocol InformationMapModalContentSectionMapperContract: SectionMapperContract {}

open class InformationMapModalContentSectionMapper: InformationMapModalContentSectionMapperContract {
    public typealias RenderModel = InformationMapModalContentSectionRenderModel
    
    public typealias ViewModel = InformationMapModalContentSectionViewModelContract
    
    public typealias ObservedModel = ViewState

    @Dependency public var viewModel: any ViewModel

    public required init() {}

    public enum ViewState {
        case hidden
        case show(InformationMapModalPresentationModel)
    }

    public func getObservedPublisher(_ viewModel: any ViewModel) -> AnyPublisher<ObservedModel, Never> {
        let loadingPublisher = viewModel.loadingPublisher
        let contentPublisher = viewModel.contentPublisher

        return Publishers.CombineLatest(loadingPublisher, contentPublisher).map { loadingPublisher, contentPublisher in
            if loadingPublisher {
                return .hidden
            } else {
                if let content = contentPublisher {
                    return .show(content)
                } else {
                    return .hidden
                }
            }
        }.eraseToAnyPublisher()
    }
    
    public func map(_ model: ObservedModel) -> RenderModel {
        switch model {
        case .hidden:
            return .hidden
        case .show(let content):
            let data = RenderModel.InformationMapModalContentSectionData(title: content.title,
                                                                         description: content.description,
                                                                         location: content.location,
                                                                         link: content.link,
                                                                         startTime: content.startTime,
                                                                         schedule: content.schedule)
            return .show(data)
        }
    }
    
}
