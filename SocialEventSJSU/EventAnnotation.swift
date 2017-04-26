//
//  EventAnnotation.swift
//  SocialEventSJSU
//
//  Created by Administrator on 4/25/17.
//  Copyright © 2017 KitoMam. All rights reserved.
//

import Foundation
import MapKit

class EventAnnotation: NSObject, MKAnnotation {
    var eventName: String = ""
    var locationName: String
    var coordinate: CLLocationCoordinate2D
    
    
    init(eventName: String, locationName: String, coordinate: CLLocationCoordinate2D){
        self.eventName = eventName
        self.locationName = locationName
        self.coordinate = coordinate
        
        super.init()
    }
    var title: String? {
        return eventName
    }
    
    var subtitle: String? {
        return locationName
    }
    
}
