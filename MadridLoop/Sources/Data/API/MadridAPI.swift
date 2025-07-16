//
//  MadridAPI.swift
//  MadridLoop
//
//  Created by Alex Ciprian lopez on 13/7/25.
//

import DependencyInjector
import DataLayer

public protocol MadridAPIContract: Instanciable {
    func getEventsCalendar() -> HTTPAPIContract
    func getDogsInformation(postalCode: String) -> HTTPAPIContract
}

open class MadridAPI: MadridAPIContract {
    public required init () { }

    open func getEventsCalendar() -> HTTPAPIContract {
        GetEventsCalendar()
    }

    open func getDogsInformation(postalCode: String) -> HTTPAPIContract {
        GetDogsInformation(cod_postal: postalCode)
    }
}

private extension MadridAPI {
    struct GetEventsCalendar: HTTPAPIContract {
        public init() {}

        public var method = "GET"
        public var path: String { "https://datos.madrid.es/egob/catalogo/206974-0-agenda-eventos-culturales-100.json" }
    }

    struct GetDogsInformation: HTTPAPIContract {
        private let cod_postal: String

        public init(cod_postal: String) {
            self.cod_postal = cod_postal
        }

        public var method = "GET"

        public var path: String {
            "https://datos.madrid.es/egob/catalogo/300081-12105312-papeleras-bolsas-excrementos.{responseContentType}?COD_POSTAL=\(cod_postal)"
        }
    }
}
