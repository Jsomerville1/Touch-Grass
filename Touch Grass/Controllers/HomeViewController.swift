import UIKit
import MapKit
import CoreLocation

// Event/Activity struct
struct Event {
    let coordinate: CLLocationCoordinate2D
    let title: String
    let tag: String  // This can be "kayaking", "hiking", etc.
    let tripName: String
    let tripHost: String
    let tripDescription: String
    let address: String
    let city: String
    let state: String
    let max: String
    let current: String
    let distance: String
}





// Temporary demo events
let events: [Event] = [
    Event(
        coordinate: CLLocationCoordinate2D(latitude: 28.6024, longitude: -81.2001),
        title: "Kayaking in The Uh.. Fountain",
        tag: "kayaking",
        tripName: "Boats!",
        tripHost: "Jeff P.",
        tripDescription: "A fun kayaking trip in the fountain at UCF.",
        address: "4000 Central Florida Blvd",
        city: "Orlando",
        state: "FL",
        max: "9",
        current: "3",
        distance: "0.8 miles"
    ),
    Event(
        coordinate: CLLocationCoordinate2D(latitude: 28.8024, longitude: -81.6001),
        title: "Let's Go Paddlin'",
        tag: "kayaking",
        tripName: "Rainbow River Kayaking",
        tripHost: "Mike A.",
        tripDescription: "Meeting at the parking lot at Rainbow River! We have space for 10 People. Come one come all!",
        address: "123 Rainbow Road",
        city: "Mario Kart",
        state: "FL",
        max: "10",
        current: "2",
        distance: "38.4 miles"
    ),
    
    
    
    // ... add more events
]





// Properties for Event Pop Up
extension HomeViewController: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return HalfSizePresentationController(presentedViewController: presented, presenting: presenting)
    }
}





class HomeViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    public var mapView = MKMapView()
    let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        setupMapView()
        checkLocationAuthorization()
    }
    
    
    
    // map setup
    func setupMapView() {
        self.view.addSubview(mapView)

        // Map Configuration
        mapView.mapType = .standard
        
        mapView.delegate = self  // Set the delegate
        
        // Add constraints to position the map on the screen
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50).isActive = true
        mapView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50).isActive = true
        mapView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        mapView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        
        // Set default zoom level
        let center = CLLocationCoordinate2D(latitude: 28.6013, longitude: -81.2001)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
        mapView.setRegion(region, animated: true)
    }

    
    // verify user location access enabled
    func checkLocationAuthorization() {
        switch locationManager.authorizationStatus {
        case .authorizedWhenInUse:
            mapView.showsUserLocation = true
            locationManager.startUpdatingLocation()
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .denied, .restricted, .authorizedAlways:
            // Handle each case if needed
            break
        @unknown default:
            break
        }
    }

    
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkLocationAuthorization()
    }
    
    
    
    //Displays kayaking pins (for now)
    func displayEventsOnMap(withTag tag: String) {
        mapView.removeAnnotations(mapView.annotations)
        
        let filteredEvents = events.filter { $0.tag == tag }
        
        let annotations = filteredEvents.map { event -> MKPointAnnotation in
            let annotation = MKPointAnnotation()
            annotation.coordinate = event.coordinate
            annotation.title = event.title
            return annotation
        }
        
        mapView.addAnnotations(annotations)
    }
    
    
    // Function for Trip Info
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        guard let annotationTitle = view.annotation?.title, let title = annotationTitle else { return }

        // Identify the selected event from the events array
        let selectedEvent = events.first { $0.title == title }
        
        if let selectedEvent = selectedEvent {
            let aboutTripVC = AboutTripViewController()
            aboutTripVC.event = selectedEvent // Pass the event data to the AboutTripViewController
            aboutTripVC.modalPresentationStyle = .custom
            aboutTripVC.transitioningDelegate = self
            present(aboutTripVC, animated: true, completion: nil)
        }
    }


}

