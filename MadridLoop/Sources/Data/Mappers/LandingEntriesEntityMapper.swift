//
//  LandingEntriesEntityMapper.swift
//  MadridLoop
//
//  Created by Alex Ciprian lopez on 13/7/25.
//

import DependencyInjector

public protocol LandingEntriesEntityMapperContract: Instanciable {
    func map(_ input: Data) throws -> LandingEntriesEntity
    func map(_ input: LandingEntriesEntity) throws -> [EventEntryModel]
}

open class LandingEntriesEntityMapper: LandingEntriesEntityMapperContract {
    public required init() {}

    open func map(_ input: Data) throws -> LandingEntriesEntity {
        return try input.map(LandingEntriesEntity.self)
    }

    open func map(_ input: LandingEntriesEntity) throws -> [EventEntryModel] {
        guard let graph = input.graph else {
            throw NSError(domain: "Error parsing JSON",
                          code: 1)
        }
        var result: [EventEntryModel] = []
        for i in graph {
            let location: EventEntryModel.LocationModel = .init(latitude: i.location?.latitude ?? 0,
                                                                  longitude: i.location?.longitude ?? 0)
            let address: EventEntryModel.AddressModel = .init(district: "Madrid",
                                                              locality: i.address?.area?.locality,
                                                              postalCode: i.address?.area?.postalCode,
                                                              streetAddress: i.address?.area?.streetAddress)
            result.append(EventEntryModel(id: i.id ?? "",
                                            title: i.title ?? "",
                                            description: i.description ?? "",
                                            free: i.free,
                                            price: i.price,
                                            dtStart: i.dtstart ?? "",
                                            dtEnd: i.dtend,
                                            location: location,
                                            link: i.link,
                                            address: address))
        }
        return result
    }
}
