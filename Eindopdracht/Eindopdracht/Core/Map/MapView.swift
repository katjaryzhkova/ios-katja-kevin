
import SwiftUI
import MapKit


struct MapView: UIViewRepresentable {
    var coordinate: CLLocationCoordinate2D
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.setRegion(MKCoordinateRegion(center: coordinate, latitudinalMeters: 10000, longitudinalMeters: 10000), animated: true)
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        // Update the map view if needed
    }
}
