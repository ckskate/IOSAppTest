//
//  Capsule.swift
//  PhotoLocationTest
//
//  Created by Connor Killion on 11/7/15.
//  Copyright © 2015 Connor Killion. All rights reserved.
//

import Foundation
import MapKit

class Capsule: NSObject, MKAnnotation {
    let title: String?
    let image: UIImage
    let coordinate: CLLocationCoordinate2D
    
    init(title: String, image: UIImage, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.image = image
        self.coordinate = coordinate
        
        super.init()
    }

}
