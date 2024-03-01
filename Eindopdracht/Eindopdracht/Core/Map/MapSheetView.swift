import SwiftUI
import MapKit

struct MapSheetView: View {
    @State var city: String
    @State private var coordinates: CLLocationCoordinate2D?

    @Environment(\.verticalSizeClass) var verticalSizeClass: UserInterfaceSizeClass?
    @Environment(\.horizontalSizeClass) var horizontalSizeClass: UserInterfaceSizeClass?
    @Environment(\.presentationMode) var presentationMode
    
    @StateObject var locationManager = LocationManager()

    var body: some View {
        NavigationView {
            VStack {
                if let coordinates = coordinates {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.white)
                        .frame(
                            width: UIScreen.main.bounds.width - 40,
                            height: horizontalSizeClass == .compact && verticalSizeClass == .regular ? UIScreen.main.bounds.height - 200 : UIScreen.main.bounds.height - 80
                        )
                        .overlay(
                            MapView(coordinates: coordinates)
                        )
                        .cornerRadius(20)
                        .shadow(radius: 5)
                    
                    Text(locationManager.getLocationString(city: city, coordinates: coordinates))
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
            coordinates = placemarks?.first?.location?.coordinate
            if coordinates == nil {
                coordinates = CLLocationCoordinate2D(latitude: 40.730610, longitude: -73.935242)
                self.city = "New York"
            }
        }
    }
}


#Preview {
    MapSheetView(city: "New York")
}
