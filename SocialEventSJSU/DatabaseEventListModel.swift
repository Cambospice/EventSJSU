//
//  databaseEventListModel.swift
//  SocialEventSJSU
//
//  Created by Administrator on 4/26/17.
//  Copyright © 2017 KitoMam. All rights reserved.
//

import Foundation
import AWSDynamoDB
import AWSMobileHubHelper
import MapKit
import CoreLocation
import CoreGraphics

class DatabaseEventListModel {
    static let dbModel = DatabaseEventListModel()
    private init(){}
    
    
    var dynamoDBObjectMapper = AWSDynamoDBObjectMapper.default()
    var events = [EventAnnotation]()
    public func scanDB() {
    let scanExpression = AWSDynamoDBScanExpression()
        dynamoDBObjectMapper.scan(EventsList.self, expression: scanExpression).continueWith(block: { (task:AWSTask<AWSDynamoDBPaginatedOutput>!) -> Any? in
            if let error = task.error as? NSError {
                print("The request failed. Error: \(error)")
            } else if let paginatedOutput = task.result {
                for event in paginatedOutput.items as! [EventsList] {
                    let annotation = EventAnnotation(eventName: event._eventName!, locationName: event._eventLocation!, coordinate: CLLocationCoordinate2DMake(CLLocationDegrees(event._latitude!),CLLocationDegrees(event._longitude!)))
                    self.events.append(annotation)
                }
            }
            
            return ()
            
        })
        return
    }
}
