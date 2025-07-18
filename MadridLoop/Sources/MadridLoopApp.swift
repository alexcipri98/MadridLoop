import Navigation
import SwiftUI
import MapKit

@main
struct MadridLoopApp: App {

    let manager = UserLocationManager()
    let locations = [Location(id: "1", coordinate: CLLocationCoordinate2D(latitude: 40.4168, longitude: -3.7038)),
                     Location(id: "2", coordinate: CLLocationCoordinate2D(latitude: 40.4168, longitude: -3.7036))]

    init() {
        NavigationModule.inject()
        LandingModule.inject()
        LandingEventSectionModule.inject()
        LandingHeaderSectionModule.inject()
        LandingDogSectionModule.inject()
        LandingMarketsSectionModule.inject()
        DataModule.inject()
        DomainModule.inject()
        MapModule.inject()
        MapContentSectionModule.inject()
        MapHeaderSectionModule.inject()
        InformationMapModalModule.inject()
        InformationMapModalHeaderSectionModule.inject()
        InformationMapModalContentSectionModule.inject()
        Router.shared.setRoot(IncomingNavigation.entryPoint(identifier: ""))
    }

    var body: some Scene {
         WindowGroup {
            UIKitNavigationView.shared.environmentObject(Router.shared).background(Color.gray.opacity(0.3))
        }
    }
}
