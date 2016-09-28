//
//  MainViewController.swift
//  Tip Calculator
//
//  Tip Calculator is a tip application that allows the user
//  to customize and determine what his or her party should
//  tip given any amount.
//
//  Created by Stefan Auvergne on 1/22/16.
//  Copyright © 2016 Stefan Auvergne. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    //number formatter
     fmt.numberStyle = NumberFormatter.Style.currency
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let defaultTipP = "Default Tip Percent"
        let defaultSplit = "Default Splits"
        
        //Persists data
        let prefs = UserDefaults.standard
        
        if let temp = prefs.object(forKey: defaultSplit) as? Int{
            let segmentedValuePassed = temp
            segmentedControlBar.selectedSegmentIndex = (segmentedValuePassed)
        }else{
            segmentedControlBar.selectedSegmentIndex = 1
        }
        
        if let temp2 = prefs.object(forKey: defaultTipP) as? Int{
            let tipPercentPassed = temp2
            percentageBarOutlet.value = Float(tipPercentPassed)
            percentageLabel.text = String(tipPercentPassed)
        }else{
            percentageBarOutlet.value = 15
        }
        
        doCalculate()
    }

    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var percentageLabel: UILabel!
    @IBOutlet weak var totalTip: UITextField!
    @IBOutlet weak var totalAmount: UITextField!
    @IBOutlet weak var tipEach: UITextField!
    @IBOutlet weak var totalEach: UITextField!
    @IBOutlet weak var percentageBarOutlet: UISlider!
    @IBOutlet weak var segmentedControlBar: UISegmentedControl!
    
    var fmt = NumberFormatter()
    var amountEntered:Double = 0.0
    var percentageSlide:Double = 0.0
    var segmentedValue:Double = 1.0
    
    
    func doCalculate(){
    amountTextField.resignFirstResponder()
    
    let str:String = amountTextField.text!
    
    if let temp = Double(str){
        amountEntered = temp
    }else{
        amountEntered = 0.0
    }
    
    performOperation()
    }
    
    @IBAction func calculateBtn(_ sender: UIButton) {
        doCalculate()
    }

    @IBAction func percentageSlideBar(_ sender: UISlider) {
        
        let i = Int(sender.value)
        percentageLabel.text = String(i)
        percentageSlide = Double(percentageBarOutlet.value)
        performOperation()
    }
    
    @IBAction func segmentedControlTest(_ sender: UISegmentedControl) {
        segmentedValue = Double(sender.selectedSegmentIndex+1)
        performOperation()
    }

    func performOperation(){
        let tip = Double((amountEntered*percentageSlide)/100)
        totalTip.text = fmt.string(from: tip as NSNumber)
        
        let amount:Double = (amountEntered + tip)
        totalAmount.text = fmt.string(from: amount as NSNumber)
        
        let divideTip:Double = tip/segmentedValue
        tipEach.text = fmt.string(from: divideTip as NSNumber)
        
        let each:Double = ((divideTip)+(amountEntered/segmentedValue))
        totalEach.text = fmt.string(from: each as NSNumber)
        
    }
    
    //Reset buttons restores all values to default values or 0
    @IBAction func Reset(_ sender: UIButton) {
    
        totalTip.text = fmt.string(from: 0)
        totalAmount.text = fmt.string(from: 0)
        tipEach.text = fmt.string(from: 0)
        totalEach.text = fmt.string(from: 0)
        amountTextField.text = String("")
        percentageLabel.text = String(15)
        segmentedControlBar.selectedSegmentIndex = 0
        percentageBarOutlet.value = 15
        
        }
}

