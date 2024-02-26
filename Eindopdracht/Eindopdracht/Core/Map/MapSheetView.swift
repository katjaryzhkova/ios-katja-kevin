
import SwiftUI
import MapKit

struct MapSheetView: View {
    let city: String
    @State private var coordinate: CLLocationCoordinate2D?
    
    var body: some View {
        NavigationView {
            VStack {
                if let coordinate = coordinate {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.white)
                        .frame(width: UIScreen.main.bounds.width - 40, height: 430)
                        .overlay(
                            MapView(coordinate: coordinate)
                        )
                        .cornerRadius(20)
                        .shadow(radius: 5)
                } else {
                    ProgressView()
                }
            }
            .onAppear {
                geocodeCity(city)
            }
        }
    }
    
    func geocodeCity(_ city: String) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(city) { placemarks, error in
            if let error = error {
                print("Geocoding failed with error: \(error.localizedDescription)")
                return
            }
            if let placemark = placemarks?.first, let location = placemark.location {
                coordinate = location.coordinate
            } else {
                print("No location found for the city: \(city)")
            }
        }
    }
}

// Helper struct
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

#Preview {
    MapSheetView(city: "New York")
}
