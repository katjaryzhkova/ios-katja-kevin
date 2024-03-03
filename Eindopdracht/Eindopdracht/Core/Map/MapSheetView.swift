import SwiftUI
import MapKit

/**
 View containing a map showcasing the cat's location as well as the user's
 distance to the cat.
 */
struct MapSheetView: View {
    /**
     The city the cat is located in.
     */
    @State var city: String
    
    /**
     The cat's coordinates.
     */
    @State private var coordinates: CLLocationCoordinate2D?
    
    /**
     A placeholder location that is displayed if the randomly person API's
     randomly generated location cannot be displayed. This placeholder
     location points to New York City.
     */
    private let placeholderLocation = CLLocation(latitude: 40.730610, longitude: -73.935242)
    
    /**
     Used to determine whether the phone is in landscape or portrait mode.
     */
    @Environment(\.verticalSizeClass) var sizeClass: UserInterfaceSizeClass?
    
    /**
     The dismiss property is used to navigate back from the map page to the tinder page.
     */
    @Environment(\.dismiss) var dismiss
    
    /**
     The location manager which is used to get the user's GPS location
     as well as for calculating the distance from the user to the cat.
     */
    @StateObject var locationManager = LocationManager()

    var body: some View {
        NavigationView {
            VStack {
                if let coordinates = coordinates {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.white)
                        .frame(
                            width: UIScreen.main.bounds.width - 40,
                            height: sizeClass == .regular ? UIScreen.main.bounds.height - 200 : UIScreen.main.bounds.height - 80
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
                dismiss()
            }) {
                Text("Back")
            })
            .onAppear {
                getCityCoordinates(city)
            }
        }
    }

    /**
     Gets the coordinates of a given city and sets the result in the `coordinates` property.
     
     @param city The city whose coordinates need to be fetched.
     */
    func getCityCoordinates(_ city: String) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(city) { placemarks, error in
            coordinates = placemarks?.first?.location?.coordinate
            
            // Display a placeholder location if the randomly generated
            // location cannot be displayed.
            if coordinates == nil {
                coordinates = CLLocationCoordinate2D(
                    latitude: placeholderLocation.coordinate.latitude,
                    longitude: placeholderLocation.coordinate.longitude
                )
                self.city = "New York"
            }
        }
    }
}


#Preview {
    MapSheetView(city: "New York")
}
