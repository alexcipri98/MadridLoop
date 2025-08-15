import Navigation
import SwiftUI
import MapKit
import FirebaseCore

@main
struct MadridLoopApp: App {

    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

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
        MapFiltersSectionModule.inject()
        InformationMapModalModule.inject()
        InformationMapModalHeaderSectionModule.inject()
        InformationMapModalContentSectionModule.inject()
        ListEventsModule.inject()
        ListEventsHeaderSectionModule.inject()
        ListEventsFiltersSectionModule.inject()
        ListEventsContentSectionModule.inject()
        ListMerchantsModule.inject()
        ListMerchantsHeaderSectionModule.inject()
        ListMerchantsContentSectionModule.inject()
        GenericErrorSectionModule.inject()
        VersionUpdateModule.inject()
        VersionUpdateContentSectionModule.inject()
        LocationPermissionModule.inject()
        LocationPermissionContentSectionModule.inject()
        Router.shared.setRoot(IncomingNavigation.entryPoint(identifier: ""))
    }

    var body: some Scene {
         WindowGroup {
            UIKitNavigationView.shared.environmentObject(Router.shared).background(Color.gray.opacity(0.3))
        }
    }
}
