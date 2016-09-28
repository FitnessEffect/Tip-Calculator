//
//  SettingsViewController.swift
//  Tip Calculator
//
//  SettingsViewController allows users to save their 
//  preferences as far as splitting the total and percentage
//  to tip.
//
//  Created by Stefan Auvergne on 1/31/16.
//  Copyright © 2016 Stefan Auvergne. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
let prefs = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
   
    //Saves the last chosen values for the segmented control bar and picker view
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let temp = prefs.object(forKey: defaultSplit) as? Int{
       settingSegmentedBarOutlet.selectedSegmentIndex = temp
       }else{
            print("No such value")
        }
        
       if let temp = prefs.object(forKey: defaultTipP) as? Int{
            pickerOutlet.selectRow(temp, inComponent: 0, animated: true)
        }else{
            print("No such value")
        }
   }
    
    @IBOutlet weak var settingSegmentedBarOutlet: UISegmentedControl!
    @IBOutlet weak var pickerOutlet: UIPickerView!
    
    var sSegmentedValue:Double = 0.0
    var pickerTipP:Int = 0
    let defaultSplit = "Default Splits"
    let defaultTipP = "Default Tip Percent"
    let tipPercentage = ["0","1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30"]
    
    //Picker View Controller: Number of components set to 1
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    //Picker View Controller: Number of rows set to array length
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            return tipPercentage.count
    }
    
    //Picker View Controller: Labels each row with the the strings in the array.
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return tipPercentage[row]
    }
    
    //Picker View Controller: selects the current value of the picker view
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
       let temp = tipPercentage[pickerView.selectedRow(inComponent: 0)]
        pickerTipP = Int(temp)!
        
    }

    
    @IBAction func SettingsSegmentedValue(_ sender: UISegmentedControl) {
        sSegmentedValue = Double(sender.selectedSegmentIndex)
    }
    
    //Save button persists the segmented bar value and tip percentage to Main View Controller using NSUserDefault
    @IBAction func save(_ sender: UIButton) {
        prefs.set(sSegmentedValue, forKey: defaultSplit)
        prefs.set(pickerTipP, forKey: defaultTipP)
        dismiss(animated: true, completion: nil)
    }
    
    //Cancel button returns to view controller
    @IBAction func Cancel(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
