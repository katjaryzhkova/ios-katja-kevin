
import SwiftUI
import MapKit

struct MapSheetView: View {
    
    let city: String
    
    @State private var coordinate: CLLocationCoordinate2D?
    
    @Environment(\.presentationMode) var presentationMode
    
    
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
            .frame(height: 200)
            .navigationBarItems(trailing: Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                Text("Back")
            })
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


#Preview {
    MapSheetView(city: "New York")
}
