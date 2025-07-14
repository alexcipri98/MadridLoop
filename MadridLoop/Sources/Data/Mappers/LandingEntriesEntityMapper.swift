//
//  LandingEntriesEntityMapper.swift
//  MadridLoop
//
//  Created by Alex Ciprian lopez on 13/7/25.
//

import DependencyInjector

public protocol LandingEntriesEntityMapperContract: Instanciable {
    func map(_ input: Data) throws -> LandingEntriesEntity
    func map(_ input: LandingEntriesEntity) throws -> [LandingEntryModel]
}

open class LandingEntriesEntityMapper: LandingEntriesEntityMapperContract {
    public required init() {}

    open func map(_ input: Data) throws -> LandingEntriesEntity {
        return try input.map(LandingEntriesEntity.self)
    }

    open func map(_ input: LandingEntriesEntity) throws -> [LandingEntryModel] {
        guard let graph = input.graph else {
            throw NSError(domain: "Error parsing JSON",
                          code: 1)
        }
        var result: [LandingEntryModel] = []
        for i in graph {
            let location: LandingEntryModel.LocationModel = .init(latitude: i.location?.latitude ?? 0,
                                                                  longitude: i.location?.longitude ?? 0)
            let address: LandingEntryModel.AddressModel = .init(district: "Madrid",
                                                                locality: i.address?.area?.locality,
                                                                postalCode: i.address?.area?.postalCode,
                                                                streetAddress: i.address?.area?.streetAddress)
            result.append(LandingEntryModel(id: i.id ?? "",
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
