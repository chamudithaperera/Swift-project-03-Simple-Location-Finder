//
//  ViewController.swift
//  whereWasI
//
//  Created by Chamuditha Kavishan on 2024-06-01.
//

import UIKit
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate
{
    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        if let oldCoords = DataStore().GetLastLocation()
        {
            let annotation = MKPointAnnotation()
            annotation.coordinate.latitude = Double(oldCoords.latitude)!
            annotation.coordinate.longitude = Double(oldCoords.longitide)!
            
            annotation.title = "I was here!"
            annotation.subtitle = "Remember?"
            mapView.addAnnotation(annotation)
        }
    }
    
    @IBAction func SaveButtonClicked(_ sender: Any)
    {
        let coord = locationManager.location?.coordinate
        if let lat = coord?.latitude
        {
            if let long = coord?.longitude
            {
                DataStore().StoreDataPoints(latitude: String(lat), longitude: String(long))
            }
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus)
    {
        guard status == .authorizedWhenInUse else
        {
            print("Location not enabled")
            return
        }
        
        print("Location allowed")
        mapView.showsUserLocation = true
    }


}

