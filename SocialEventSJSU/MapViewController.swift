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

class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    var databaseEvent: DatabaseEventListModel = DatabaseEventListModel.dbModel
    var tempString = ""
    var tempString1 = ""
    
    @IBOutlet weak var mapView: MKMapView!
    
    //current location
    let managerCurrentLocation = CLLocationManager()
    
    let initialLocation = CLLocation(latitude: 37.3352, longitude:  -121.8811)
    let regionRadius: CLLocationDistance = 500
    var locationManager: CLLocationManager!
    var eventAnnotations: [EventAnnotation]{
        return databaseEvent.events
    }
    
    
    
   
    
    /*
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[0]
        
        
        let span:MKCoordinateSpan = MKCoordinateSpanMake(0.01, 0.01)
        let myLocation:CLLocationCoordinate2D = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
        let region:MKCoordinateRegion = MKCoordinateRegionMake(myLocation, span)
        
        mapView.setRegion(region, animated: true)
        self.mapView.showsUserLocation = true
    }
    */
    
    
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
 
        
        
        
        mapView.showsUserLocation = true
        
        
        managerCurrentLocation.delegate = self
        managerCurrentLocation.desiredAccuracy = kCLLocationAccuracyBest
        managerCurrentLocation.requestWhenInUseAuthorization()
        managerCurrentLocation.startUpdatingLocation()
        
        
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
    
  
  
    /*
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if !(annotation is MKUserLocation) {
            let pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: String(annotation.hash))
            
            let rightButton = UIButton(type: .contactAdd)
            rightButton.tag = annotation.hash
            
            pinView.animatesDrop = true
            pinView.canShowCallout = true
            pinView.rightCalloutAccessoryView = rightButton
            
                
            return pinView
        }
        else {
            return nil
        }
    }
    */
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
       
        let lat: Double = (view.annotation?.coordinate.latitude)!
        let user_lat : String = String(format:"%f", lat)
        
        let longti: Double = (view.annotation?.coordinate.longitude)!
        let user_longti : String = String(format:"%f", longti)
        
        tempString1 = view.annotation?.title! ?? "hello"
        
        
        
        if view.isSelected {
            let refreshAlert = UIAlertController(title: tempString1, message: "Would like to go to this event", preferredStyle: UIAlertControllerStyle.alert)
            
            refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                self.getDirection(latiB: user_lat, longtiB: user_longti)

            }))
            
            refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
                print("Handle Cancel Logic here")
            }))
            
            present(refreshAlert, animated: true, completion: nil)
        }
        
    
        /*
        
        tempString1 = view.annotation?.title! ?? "hello"
      
        //getDirection(latiB: user_lat, longtiB: user_longti)
        print("1")
       print(tempString)
         
         
        */
    }
    
    //need to provide longtitude and latitude of B
    func getDirection(latiB: String, longtiB: String ){
        
        var urlString = "http://maps.google.com/maps?"
        
        urlString += "saddr="
        urlString += ""
        urlString += ""
        urlString += ""
        urlString += "&daddr="
        urlString += latiB
        urlString += ","
        urlString += longtiB
        
        let url = URL(string: urlString)!
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }

        
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
