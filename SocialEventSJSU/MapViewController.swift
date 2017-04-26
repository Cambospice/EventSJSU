//
//  MapViewController.swift
//  SocialEventSJSU
//
//  Created by Administrator on 4/25/17.
//  Copyright © 2017 KitoMam. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import CoreGraphics

class MapViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    let initialLocation = CLLocation(latitude: 37.3352, longitude:  -121.8811)
    let regionRadius: CLLocationDistance = 500
    var locationManager: CLLocationManager!
    let eventAnnotations: [EventAnnotation] =
    [EventAnnotation(eventName: "Event Career Talk", locationName: "Student Union Ballroom", coordinate:CLLocationCoordinate2DMake(37.3363, -121.8813)),
     EventAnnotation(eventName: "Open House", locationName: "Engineering Building", coordinate: CLLocationCoordinate2DMake(37.3370, -121.8816))
    ]
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mapView.delegate = self
            func centerMapOnLocation(location:CLLocation) {
                let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                          regionRadius * 2.0, regionRadius * 2.0)
                mapView.setRegion(coordinateRegion, animated: true)
            }
            centerMapOnLocation(location: initialLocation)
        for eventAnnotation in eventAnnotations {
            mapView.addAnnotation(eventAnnotation)
        }
        let yourAnnotationAtIndex = 0
        mapView.selectAnnotation(mapView.annotations[yourAnnotationAtIndex], animated: true)// Do any additional setup after loading the view.
        mapView.showsPointsOfInterest = true
    }
    
    

    //Map Annotation in progress
   /* override func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        if (annotation is MKUserLocation) {
            return nil
        }
        
        if (annotation.isKindOfClass(CustomAnnotation)) {
            let customAnnotation = annotation as? CustomAnnotation
            mapView.translatesAutoresizingMaskIntoConstraints = false
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "CustomAnnotation") as MKAnnotationView!
            
            if (annotationView == nil) {
                annotationView = customAnnotation?.annotationView()
            } else {
                annotationView!.annotation = annotation;
            }
            
            self.addBounceAnimationToView(annotationView)
            return annotationView
        } else {
            return nil
        }
    }*/
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
