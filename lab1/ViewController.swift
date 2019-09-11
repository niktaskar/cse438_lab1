//
//  ViewController.swift
//  lab1
//
//  Created by Nikash Taskar on 9/7/19.
//  Copyright © 2019 Nikash Taskar. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIPickerViewDataSource,UIPickerViewDelegate
{
    
    @IBOutlet weak var originalLabel: UILabel!
    
    @IBOutlet weak var discountLabel: UILabel!
    
    @IBOutlet weak var taxLabel: UILabel!
    
    @IBOutlet weak var finalLabel: UILabel!
    
    @IBOutlet weak var originalText: UITextField!
    
    @IBOutlet weak var discountText: UITextField!
    
    @IBOutlet weak var taxPicker: UIPickerView!
    
    var stateTaxes = ["Alabama": 4.00,"Alaska": 0.00,"Arizona": 5.60,"Arkansas": 6.50,"California": 7.25,"Colorado": 2.90,"Connecticut": 6.35,"Delaware": 0.00,"Florida": 6.00,"Georgia": 4.00,"Hawaii": 4.00,"Idaho": 6.00,"Illinois": 6.25,"Indiana": 7.00,"Iowa": 6.00,"Kansas": 6.50,"Kentucky": 6.00,"Louisiana": 4.45,"Maine": 5.50,"Maryland": 6.00,"Massachussetts": 6.25,"Michigan": 6.00,"Minnesota": 6.88,"Mississippi": 7.00,"Missouri": 4.23,"Montana": 0.00,"Nebraska": 5.50,"Nevada": 6.85,"New Hampshire": 0.00,"New Jersey": 6.63,"New Mexico": 5.13,"New York": 4.00,"North Carolina": 4.75,"North Dakota": 5.00,"Ohio": 5.75,"Oklahoma": 4.50,"Oregon": 0.00,"Pennsylvania": 6.00,"Rhode Island": 7.00,"South Carolina": 6.00,"South Dakota": 4.50,"Tennessee": 7.00,"Texas": 6.25,"Utah": 5.95,"Vermont": 6.00,"Virginia": 5.30,"Washington": 6.50,"West Virginia": 6.00,"Wisconsin": 5.00,"Wyoming": 4.00,"D.C.": 6.00]

    var states:[String] = ["Alabama","Alaska","Arizona","Arkansas","California","Colorado","Connecticut","Delaware","Florida","Georgia","Hawaii","Idaho","Illinois","Indiana","Iowa","Kansas","Kentucky","Louisiana","Maine","Maryland","Massachussetts","Michigan","Minnesota","Mississippi","Missouri","Montana","Nebraska","Nevada","New Hampshire","New Jersey","New Mexico","New York","North Carolina","North Dakota","Ohio","Oklahoma","Oregon","Pennsylvania","Rhode Island","South Carolina","South Dakota","Tennessee","Texas","Utah","Vermont","Virginia","Washington","West Virginia","Wisconsin","Wyoming","D.C."]
    
    var currentState = "Alabama"
    var currTax = 4.00
    
    var formatter: NumberFormatter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = NSLocale(localeIdentifier: "en_US") as Locale?
        
        originalLabel.text = "Original Price"
        discountLabel.text = "Discount %"
        taxLabel.text = "Sales Tax %"
        originalText.text = "0.00"
        discountText.text = "0.00"
        finalLabel.text = "Shopping Calculator"
        
//        for i in 0...states.count-1 {
//            print(states[i])
//        }
//        
//        for state in states {
//            print(state)
//            print(stateTaxes[state])
//        }
        
        self.view.backgroundColor = UIColor.blue
        
        self.taxPicker.delegate = self
        self.taxPicker.dataSource = self
    }
    
    // Number of columns of data
    func numberOfComponents(in taxPicker: UIPickerView) -> Int {
        return 1
    }
    
    // The number of rows of data
    func pickerView(_ taxPicker: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return states.count
    }
    
    func pickerView(_ taxPicker: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        This gets the value from the state Taxes dictionary
//        print(row)
//        print(states[row])
//        print(stateTaxes[states[row]])
        
        let select = taxPicker.selectedRow(inComponent: 0)
        
        print(select)
        print(states[select])
        
        currentState = states[select]
        currTax = stateTaxes[currentState]!
        return states[row]
    }
    
    @IBAction func originalChanged(_ sender: UITextField) {
        let val = sender.text!
        if Double(val) != nil && isValidInput(){
            updateView()
        }
//        else if val.contains("-"){
//            finalLabel.text = "Please input a value greater than 0"
//        }
//        else {
//            finalLabel.text = "Please input a number"
//        }
    }
    
    @IBAction func discountChanged(_ sender: UITextField) {
        let val = sender.text!
        if Double(val) != nil  && isValidInput(){
            updateView()
        }
//        else {
//            finalLabel.text = "Please input a number"
//        }
    }
    
    func updateView(){
        let price = Double(originalText.text! ) ?? 0.0
        let discount = Double(discountText.text! ) ?? 0.0
        let tax = currTax + 100
        
        let priceAfterDiscount = Double((price*(100-discount)/100) ?? 0.0)
        let finalPrice = priceAfterDiscount*(tax/100.00) ?? 0.0
//        print(finalPrice)
    
        finalLabel.text = "Final Price: $\(String(format: "%.2f", finalPrice))"
    }
    
    func isValidInput() -> Bool{
        let price:Double? = Double(originalText.text!)
        let discount:Double? = Double(discountText.text!)
        
        if (price == nil) {
            finalLabel.text = "Please input a valid price"
            return false
        }
        
        if (price != nil  && Double(price!) < 0.00) {
            finalLabel.text = "Please input a price greater than 0"
//            finalLabel.text = "Invalid Input"
            return false
        }
        
        if (discount == nil) {
            finalLabel.text = "Please input a valid discount"
            return false
        }
        
        if (discount != nil  && (Double(discount!) < 0.00  || Double(discount!) > 100.0)) {
            finalLabel.text = "Please input a discount between 0 and 100"
//            finalLabel.text = "Invalid Input"
            return false
        }
        
        return true
    }
    
    
}

