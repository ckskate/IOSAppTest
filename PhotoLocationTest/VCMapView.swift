//
//  VCMapView.swift
//  PhotoLocationTest
//
//  Created by Connor Killion on 11/7/15.
//  Copyright © 2015 Connor Killion. All rights reserved.
//

import Foundation
import MapKit

extension MapViewController: MKMapViewDelegate {
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        
        if let annotation = annotation as? Capsule {
            let identifier = "pin"
            var view: MKPinAnnotationView
            if let dequeuedView = mapView.dequeueReusableAnnotationViewWithIdentifier(identifier) as? MKPinAnnotationView {
                dequeuedView.annotation = annotation
                view = dequeuedView
            } else {
                view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                view.canShowCallout = true
                view.calloutOffset = CGPoint(x: 0, y: 5)
                view.pinTintColor = UIColor.blueColor()
                view.image = annotation.image
                view.rightCalloutAccessoryView = UIButton(type: .DetailDisclosure) as UIView
            }
            return view
        }
        return nil
    }
}
