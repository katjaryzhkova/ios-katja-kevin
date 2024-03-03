import Foundation
import CoreLocation
import Combine

/**
 Utility class which is responsible for fetching the user's GPS location.
 */
class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    /**
     The underlying instance of `CLLocationManager` which is
     responsible for fetching the user's location.
     */
    private let locationManager = CLLocationManager()
    
    /**
     The user's last recorded location.
     */
    @Published var location: CLLocation?
    
    /**
     A placeholder location that is displayed if the user's location cannot
     be fetched. This placeholder location points to New York City.
     */
    private let placeholderLocation = CLLocation(latitude: 40.730610, longitude: -73.935242)

    override init() {
        super.init()
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    /*
     Callback function which is called by the `CLLocationManager`
     whenever the user's location is updated.
     */
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if locations.last != nil {
            location = locations.last
        }
    }
    
    /**
     Calculates the distance between the user and a given city and
     returns a formatted output of the location information.
     
     @returns A formatted string containing the cat's city as well as the
     distance from the user to the cat.
     */
    func getLocationString(city: String, coordinates: CLLocationCoordinate2D?) -> String {
        let catLocation = CLLocation(
            latitude: CLLocationDegrees(coordinates?.latitude ?? placeholderLocation.coordinate.latitude),
            longitude: CLLocationDegrees(coordinates?.longitude ?? placeholderLocation.coordinate.longitude)
        )
        
        // divide distance by 1000 to get distance in km instead of meters
        let distance = Int((location?.distance(from: catLocation) ?? 0) / 1000)
        
        return "\(city) - \(distance)km away"
    }
}
