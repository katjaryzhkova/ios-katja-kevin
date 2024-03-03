import SwiftUI
import MapKit

/**
 The view of the map used to display a cat's location.
 */
struct MapView: UIViewRepresentable {
    /**
     The cat's coordinates.
     */
    var coordinates: CLLocationCoordinate2D
    
    /**
     Creates the map view
     */
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.setRegion(MKCoordinateRegion(center: coordinates, latitudinalMeters: 10000, longitudinalMeters: 10000), animated: true)
        return mapView
    }
    
    /**
     Updates the map view
     */
    func updateUIView(_ uiView: MKMapView, context: Context) { }
}
