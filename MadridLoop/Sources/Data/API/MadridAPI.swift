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
    func getDogsInformation(distrit: String) -> HTTPAPIContract
    func getNormalFonts(distrit: String) -> HTTPAPIContract
    func getDogsFonts(distrit: String) -> HTTPAPIContract
    func getMarkets() -> HTTPAPIContract
    func getVersion(version: String) -> HTTPAPIContract
}

open class MadridAPI: MadridAPIContract {
    public required init () { }

    open func getEventsCalendar() -> HTTPAPIContract {
        GetEventsCalendar()
    }

    open func getDogsInformation(distrit: String) -> HTTPAPIContract {
        GetDogsInformation(distrit: distrit)
    }

    open func getNormalFonts(distrit: String) -> any HTTPAPIContract {
        GetNormalFonts(distrit: distrit)
    }

    open func getDogsFonts(distrit: String) -> any HTTPAPIContract {
        GetDogsFonts(distrit: distrit)
    }

    open func getMarkets() -> any HTTPAPIContract {
        GetMarkets()
    }

    open func getVersion(version: String) -> any HTTPAPIContract {
        GetVersion(version: version)
    }
}

private extension MadridAPI {
    struct GetEventsCalendar: HTTPAPIContract {
        public init() {}

        public var method = "GET"
        public var path: String { "https://datos.madrid.es/egob/catalogo/206974-0-agenda-eventos-culturales-100.json" }
    }

    struct GetDogsInformation: HTTPAPIContract {
        private let distrit: String

        public init(distrit: String) {
            self.distrit = distrit
        }

        public var method = "GET"

        public var path: String {
            "https://datos.madrid.es/egob/catalogo/300081-12105312-papeleras-bolsas-excrementos.{responseContentType}?pageSize=500&DISTRITO=\(distrit)"
        }
    }

    struct GetNormalFonts: HTTPAPIContract {
        private let distrit: String

        public init(distrit: String) {
            self.distrit = distrit
        }
        
        public var method = "GET"
        
        public var path: String {
            "https://datos.madrid.es/egob/catalogo/300051-12105179-fuentes.{responseContentType}?DISTRITO=\(distrit)"
        }
    }

    struct GetDogsFonts: HTTPAPIContract {
        private let distrit: String
        
        public init(distrit: String) {
            self.distrit = distrit
        }
        
        public var method = "GET"
        
        public var path: String {
            "https://datos.madrid.es/egob/catalogo/50055-12105277-fuentes-mascotas.{responseContentType}?DISTRITO=\(distrit)"
        }
    }

    struct GetMarkets: HTTPAPIContract {
        public init() {}
        
        public var method = "GET"
        
        public var path: String {
            "https://datos.madrid.es/egob/catalogo/202105-0-mercadillos.json"
        }
    }

    struct GetVersion: HTTPAPIContract {
        private let version: String

        public init(version: String) {
            self.version = version
        }

        public var method = "GET"

        public var path: String {
            "https://checkappversion-3o573a5zhq-uc.a.run.app?version=\(version)"
        }
    }
}
