//
//  DogsInformationModel.swift
//  MadridLoop
//
//  Created by Alex Ciprian lopez on 15/7/25.
//

import Foundation

open class DogsInformationModel: Codable {
    let id: String
    let typeOfElement: TypeOfElementModel
    let barrio: String?
    let distrito: String?
    let location: LocationModel
    let direction: String?
    
    public init(id: String,
                typeOfElement: TypeOfElementModel,
                barrio: String?,
                distrito: String?,
                localization: LocationModel,
                direction: String?) {
        self.id = id
        self.typeOfElement = typeOfElement
        self.barrio = barrio
        self.distrito = distrito
        self.location = localization
        self.direction = direction
    }

    open class LocationModel: Codable {
        let latitude: Double
        let longitude: Double
        
        public init(latitude: Double,
                    longitude: Double) {
            self.latitude = latitude
            self.longitude = longitude
        }
    }

    public enum TypeOfElementModel: String, Codable {
        case trash
        case font
        case dogFont
        case park
    }
}

