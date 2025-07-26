//
//  ListEventsContentSectionMapper.swift
//  MadridLoop
//
//  Created by Alex Ciprian lopez on 13/7/25.
//

import Combine
import PresentationLayer

public protocol ListEventsContentSectionMapperContract: SectionMapperContract {}

open class ListEventsContentSectionMapper: ListEventsContentSectionMapperContract {
    public typealias RenderModel = ListEventsContentSectionRenderModel
    
    public typealias ViewModel = ListEventsContentSectionViewModelContract
    
    public typealias ObservedModel = ViewState

    @Dependency public var viewModel: any ViewModel

    public required init() {}

    public enum ViewState {
        case show([EventEntryModel])
        case hidden
    }

    public func getObservedPublisher(_ viewModel: any ViewModel) -> AnyPublisher<ObservedModel, Never> {
        let loadingPublisher = viewModel.loadingPublisher
        let errorPublisher = viewModel.errorPublisher
        let dataPublisher = viewModel.entriesPublisher

        return Publishers.CombineLatest3(loadingPublisher, errorPublisher, dataPublisher).map { loader, error, data in
            if loader || error {
                return .hidden
            } else {
                return .show(data)
            }
        }.eraseToAnyPublisher()
    }
    
    public func map(_ model: ObservedModel) -> RenderModel {
        switch model {
        case .show(let entries):
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss.S"
            dateFormatter.locale = Locale(identifier: "en_US_POSIX")

            let sortedEntries = entries.sorted {
                guard let date1 = dateFormatter.date(from: $0.dtStart),
                      let date2 = dateFormatter.date(from: $1.dtStart) else {
                    return false
                }
                return date1 < date2
            }
            var result: [RenderModel.ListEventsEventDataRenderModel] = []
            for entry in sortedEntries {
                result.append(RenderModel.ListEventsEventDataRenderModel(id: entry.id,
                                                                         title: entry.title,
                                                                         description: entry.description,
                                                                         dateStart: entry.dtStart,
                                                                         dateEnd: entry.dtEnd,
                                                                         isItFree: entry.price == "Entrada gratuita",
                                                                         location: entry.address?.locality,
                                                                         link: entry.link,
                                                                         latitude: entry.location?.latitude,
                                                                         longitude: entry.location?.longitude))
            }
            return .show(result)
        case .hidden:
            return .hidden
        }
    }
    
}
