//
//  DogsInformationEntity.swift
//  MadridLoop
//
//  Created by Alex Ciprian lopez on 15/7/25.
//

import DependencyInjector

public protocol DogsTrashEntityMapperContract: Instanciable {
    func map(_ input: Data) throws -> DogTrashEntity
    func map(_ input: DogTrashEntity) throws -> [DogsInformationModel]
}

open class DogsTrashEntityMapper: DogsTrashEntityMapperContract {
    public required init() {}

    open func map(_ input: Data) throws -> DogTrashEntity {
        let cleanedData = input.cleanedInvalidEscapes() ?? input
        return try cleanedData.map(DogTrashEntity.self)
    }

    open func map(_ input: DogTrashEntity) throws -> [DogsInformationModel] {
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
                    typeOfElement: .trash,
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
