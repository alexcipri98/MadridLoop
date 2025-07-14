import Navigation
import SwiftUI
import MapKit

@main
struct MadridLoopApp: App {

    let manager = LocationManager()
    let locations = [Location(id: "1", coordinate: CLLocationCoordinate2D(latitude: 40.4168, longitude: -3.7038)),
                     Location(id: "2", coordinate: CLLocationCoordinate2D(latitude: 40.4168, longitude: -3.7036))]

    init() {
        NavigationModule.inject()
        LandingModule.inject()
        LandingEventSectionModule.inject()
        LandingHeaderSectionModule.inject()
        DataModule.inject()
        DomainModule.inject()
        Router.shared.setRoot(IncomingNavigation.entryPoint)
    }

    var body: some Scene {
        /*
         WindowGroup {
            UIKitNavigationView.shared.environmentObject(Router.shared).background(Color.gray.opacity(0.3))
        }
         */
        WindowGroup {
            MapView(
                userLocation: manager.location!,
                places: locations,
                action: { id in
                    print("tocado" + id)
                }
            )
            .environmentObject(Router.shared)
            .background(Color.gray.opacity(0.3))
        }
    }
}
