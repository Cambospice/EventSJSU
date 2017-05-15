//
//  FormViewController.swift
//  SocialEventSJSU
//
//  Created by Samnang Sok on 5/9/17.
//  Copyright © 2017 KitoMam. All rights reserved.
//

import UIKit

class FormViewController: UIViewController, UIPickerViewDataSource {
    
    @IBOutlet weak var location: UIPickerView!
    @IBOutlet weak var textBox: UITextField!
    
    var list = ["Administration", "Art Building", "Boccardo Business Complex", "Business Tower", "Career Center", "Computer Center", "Central Classroom Building", "Clark Hall", "Cooling Plant", "Campus Village A", "Campus Village B", "Campus Village C", "Corporation Yard A", "Corporation Yard B", "Dining Commons", "Dudley Moorhead Hall", "Duncan Hall", "Dwight Bentel Hall", "Engineering Building", "Event Center", "Student Union", "Duncan Hall", ""]
    
    
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
    
    
    
}
