//
//  EventsList.swift
//  MySampleApp
//
//
// Copyright 2017 Amazon.com, Inc. or its affiliates (Amazon). All Rights Reserved.
//
// Code generated by AWS Mobile Hub. Amazon gives unlimited permission to 
// copy, distribute and modify it.
//
// Source code generated from template: aws-my-sample-app-ios-swift v0.13
//

import Foundation
import UIKit
import AWSDynamoDB

class EventsList: AWSDynamoDBObjectModel, AWSDynamoDBModeling {
    
    var _userId: String?
    var _eventDate: String?
    var _description: String?
    var _eventLocation: String?
    var _eventName: String?
    var _latitude: NSNumber?
    var _longitude: NSNumber?
    
    class func dynamoDBTableName() -> String {

        return "eventsjsu-mobilehub-1740350022-EventsList"
    }
    
    class func hashKeyAttribute() -> String {

        return "_userId"
    }
    
    class func rangeKeyAttribute() -> String {

        return "_eventDate"
    }
    
    override class func jsonKeyPathsByPropertyKey() -> [AnyHashable: Any] {
        return [
               "_userId" : "userId",
               "_eventDate" : "eventDate",
               "_description" : "description",
               "_eventLocation" : "eventLocation",
               "_eventName" : "eventName",
               "_latitude" : "latitude",
               "_longitude" : "longitude",
        ]
    }
}
