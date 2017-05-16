//
//  FormViewController.swift
//  SocialEventSJSU
//
//  Created by Samnang Sok on 5/9/17.
//  Copyright © 2017 KitoMam. All rights reserved.
//

import UIKit
import AWSDynamoDB
import AWSMobileHubHelper

class FormViewController: UIViewController, UIPickerViewDataSource {
    
    @IBOutlet weak var eventName: UITextField!
    @IBOutlet weak var location: UIPickerView!
    @IBOutlet weak var textBox: UITextField!
    @IBOutlet weak var eventDescription: UITextField!
    var eventDB = DatabaseEventListModel.dbModel
    
    var list  = ["Administration", "Art Building", "Boccardo Business Complex", "Business Tower", "Career Center", "Computer Center", "Central Classroom Building", "Clark Hall", "Cooling Plant", "Campus Village A", "Campus Village B", "Campus Village C", "Corporation Yard A", "Corporation Yard B", "Dining Commons", "Dudley Moorhead Hall", "Duncan Hall", "Dwight Bentel Hall", "Engineering Building", "Event Center", "Student Union", ]
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int{
        return 1
        
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        
        return list.count
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        self.view.endEditing(true)
        return list[row]
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        self.textBox.text = self.list[row]
        self.location.isHidden = true
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if textField == self.textBox {
            self.location.isHidden = false
            
            
            textField.endEditing(true)
        }
        
    }
    
    
    @IBOutlet weak var dateField: UITextField!
    
    @IBOutlet weak var endDate: UITextField!
    
    
    let datePicker = UIDatePicker()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createDatePicker()
        // Do any additional setup after loading the view.
    }
    
    func createDatePicker()
    {
        
        datePicker.datePickerMode = .dateAndTime
        
        //toolBar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        //bar button item
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([doneButton], animated: false)
        
        dateField.inputAccessoryView = toolbar
        endDate.inputAccessoryView = toolbar
        
        //assign data in the text field
        dateField.inputView = datePicker
        endDate.inputView = datePicker
    }
    
    func donePressed()
    {
        //format date
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .short
        
        if(dateField.isEditing)
        {
            dateField.text = dateFormatter.string(from: datePicker.date)
        } else if(endDate.isEditing)
        {
            endDate.text = dateFormatter.string(from: datePicker.date)
        }
        
        
        self.view.endEditing(true)
    }
    
    func locationCoordinates(locationName: String) -> (Double, Double) {
        var latitude = 0.0
        var longitude = 0.0
        switch(locationName){
        case ("Administration"):
            latitude = 37.336560
            longitude = -121.882908
        case ("Art Building"):
            latitude = 37.335955
            longitude = -121.879763
        case ("Boccardo Business Complex"):
            latitude = 37.336501
            longitude  = -121.878754
        case ("Business Tower"):
            latitude = 37.337038
            longitude = -121.878861
        case ("Career Center"):
            latitude = 37.336743
            longitude =  -121.882834
        case("Computer Center"):
            latitude = 37.335937
            longitude = -121.883305
        case("Central Classroom Building"):
            latitude = 37.335641
            longitude = -121.881918
        case("Clark Hall"):
            latitude = 37.336035
            longitude = -121.882477
        case("Cooling Plant"):
            latitude = 37.336088
            longitude = -121.878498
        case("Campus Village A"):
            latitude = 37.334412
            longitude = -121.877497
        case("Campus Village B"):
            latitude = 37.335031
            longitude = -121.877516
        case("Campus Village C"):
            latitude = 37.335208
            longitude = -121.878064
        case("Corporation Yard A"):
            latitude = 37.338154
            longitude = -121.880229
        case("Corporation Yard B"):
            latitude = 37.338083
            longitude = -121.879561
        case("Dining Commons"):
            latitude = 37.333944
            longitude = -121.878511
        case("Dudley Moorhead Hall"):
            latitude = 37.336251
            longitude = -121.883909
        case("Dwight Bentel Hall"):
            latitude = 37.334922
            longitude = -121.882608
        case("Event Center"):
            latitude = 37.335242
            longitude = -121.880034
        case ("Engineering Building"):
            latitude = 37.3370
            longitude = -121.8816
        case ("Student Union"):
            latitude = 37.3363
            longitude = -121.8813
        case ("Duncan Hall"):
            latitude = 37.332325
            longitude = -121.881910
        default:
            return (latitude,longitude)
    }
        return (latitude, longitude)
    }
    
    @IBAction func addEvent(_ sender: Any) {
        let objectMapper = AWSDynamoDBObjectMapper.default()
        
        let itemToCreate: EventsList = EventsList()
        
        itemToCreate._userId = AWSIdentityManager.default().identityId!
        itemToCreate._eventName = eventName.text!
        itemToCreate._eventDate = dateField.text!
        itemToCreate._endDate = endDate.text!
        itemToCreate._eventLocation = textBox.text!
        itemToCreate._description = eventDescription.text!
        itemToCreate._latitude = locationCoordinates(locationName: textBox.text!).0 as NSNumber
        itemToCreate._longitude = locationCoordinates(locationName: textBox.text!).1 as NSNumber
        objectMapper.save(itemToCreate, completionHandler: {(error: Error?) -> Void in
            if let error = error {
                print("Amazon DynamoDB Save Error: \(error)")
                return
            }
            print("Item saved.")
        })
        eventDB.scanDB()
        performSegue(withIdentifier: "backToTab", sender: self)
    }
    
    
}
