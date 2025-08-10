//
//  DogsFontsEntityMapper.swift
//  MadridLoop
//
//  Created by Alex Ciprian lopez on 17/7/25.
//

import DependencyInjector

public protocol DogsFontsEntityMapperContract: Instanciable {
    func map(_ input: Data) throws -> DogsFontsEntity
    func map(_ input: DogsFontsEntity) throws -> [DogsInformationModel]
}

open class DogsFontsEntityMapper: DogsFontsEntityMapperContract {
    public required init() {}

    open func map(_ input: Data) throws -> DogsFontsEntity {
        let cleanedData = input.cleanedInvalidEscapes() ?? input
        return try cleanedData.map(DogsFontsEntity.self)
    }

    open func map(_ input: DogsFontsEntity) throws -> [DogsInformationModel] {
        guard let records = input.records else {
            throw NSError(domain: "DogsTrashEntityMapper", code: 0)
        }
        return records.compactMap { record in
            if let lat = record.latitud,
               let long = record.longitud,
               let id = record.id {
                let location = DogsInformationModel.LocationModel(
                    latitude: lat,
                    longitude: long
                )
                
                return DogsInformationModel(
                    id: id,
                    typeOfElement: .dogFont,
                    barrio: record.barrio,
                    distrito: record.distrito,
                    localization: location,
                    direction: record.direccionAux
                )
            } else {
                return nil
            }
        }
    }
}
