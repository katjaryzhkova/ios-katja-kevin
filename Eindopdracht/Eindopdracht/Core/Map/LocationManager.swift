import Foundation
import CoreLocation
import Combine

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {

    private let locationManager = CLLocationManager()
    @Published var location: CLLocation?

    override init() {
        super.init()
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if locations.last != nil {
            location = locations.last
        }
    }
    
    func getLocationString(city: String, coordinates: CLLocationCoordinate2D?) -> String {
        let catLocation = CLLocation(latitude: CLLocationDegrees(coordinates?.latitude ?? 40.730610), longitude: CLLocationDegrees(coordinates?.longitude ?? -73.935242))
        
        // divide distance by 1000 to get distance in km instead of meters
        let distance = Int((location?.distance(from: catLocation) ?? 0) / 1000)
        
        return "\(city) - \(distance)km away"
    }
}
