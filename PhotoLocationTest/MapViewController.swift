//
//  MapViewController.swift
//  PhotoLocationTest
//
//  Created by Connor Killion on 11/7/15.
//  Copyright © 2015 Connor Killion. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, CLLocationManagerDelegate {
    
    let picker = UIImagePickerController()
    let locationManager = CLLocationManager()
    
    
    // Mark: Outlets
    @IBOutlet weak var map: MKMapView!
    
    // start current location as nil
    var currentLocation: CLLocation! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        picker.delegate = self
        
        locationManager.delegate = self
        map.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        map.showsUserLocation = true
        
        if CLLocationManager.authorizationStatus() == .NotDetermined {
            self.locationManager.requestAlwaysAuthorization()
        }
        
        locationManager.startUpdatingLocation()
    }
    
    // Mark: Actions
    @IBAction func shootPhoto(sender: UIButton) {
        if UIImagePickerController.availableCaptureModesForCameraDevice(.Rear) != nil {
            picker.allowsEditing = false
            picker.sourceType = UIImagePickerControllerSourceType.Camera
            picker.cameraCaptureMode = .Photo
            picker.modalPresentationStyle = .FullScreen
            presentViewController(picker, animated: true, completion: nil)
        } else {
            noCamera()
        }
    }
    
    
    func noCamera() {
        let alertVC = UIAlertController(
            title: "No Camera",
            message: "Sorry, this device has no camera!",
            preferredStyle: .Alert)
        let okAction = UIAlertAction(
            title: "OK",
            style: .Default,
            handler: nil)
        alertVC.addAction(okAction)
        presentViewController(alertVC, animated: true, completion: nil)
        
    }
    
    // Mark: Delegates
    
    // Delegate for taking pictures
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        if currentLocation == nil{
        } else {
            
            let geocoder = CLGeocoder()
            
            geocoder.reverseGeocodeLocation(currentLocation, completionHandler: {(placemarks, error) -> Void in
                let placemark = placemarks![0] as CLPlacemark
                let cityName = placemark.locality
                
                let capsule = Capsule(title: "\(cityName!) Capsule", image: chosenImage, coordinate: self.currentLocation.coordinate)
                self.map.addAnnotation(capsule)
            })
        }
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    // Delegate for getting location
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        currentLocation = locations.last! as CLLocation
        
        let center = CLLocationCoordinate2D(latitude: currentLocation.coordinate.latitude, longitude: currentLocation.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        
        self.map.setRegion(region, animated: true)
    }
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == .AuthorizedAlways {
            manager.startUpdatingLocation()
        }
    }
    
}
