//
//  GetMarketsMapper.swift
//  MadridLoop
//
//  Created by Alex Ciprian lopez on 17/7/25.
//


import DependencyInjector

public protocol GetMarketsEntityMapperContract: Instanciable {
    func map(_ input: Data) throws -> MarketsEntity
    func map(_ input: MarketsEntity) throws -> [MarketInformationModel]
}

open class GetMarketsFontsEntityMapper: GetMarketsEntityMapperContract {
    public required init() {}

    open func map(_ input: Data) throws -> MarketsEntity {
        let cleanedData = input.cleanedInvalidEscapes() ?? input
        return try cleanedData.map(MarketsEntity.self)
    }

    open func map(_ input: MarketsEntity) throws -> [MarketInformationModel] {
        let model = input.graph?.compactMap { entity in
            MarketInformationModel(
                id: entity.id,
                title: entity.title,
                services: entity.organization?.services,
                schedule: entity.organization?.schedule,
                streetAddress: entity.address?.streetAddress,
                postalCode: entity.address?.postalCode,
                latitude: entity.location?.latitude,
                longitude: entity.location?.longitude,
                relation: entity.relation
            )
        } ?? []
        return model
    }
}
