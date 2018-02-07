//
//  ConversionViewController.swift
//  WorldTrotter
//
//  Created by Corwin, Tyler D on 1/30/18.
//  Copyright © 2018 Corwin, Tyler D. All rights reserved.
//

import UIKit

class ConversionViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet var celsiusLabel: UILabel!
    var fahrenheitValue: Measurement<UnitTemperature>? {
        didSet {
            updateCelsiusLabel()
        }
    }
    
    var celsiusValue: Measurement<UnitTemperature>? {
        if let fahrenheitValue = fahrenheitValue {
            return fahrenheitValue.converted(to: .celsius)
        } else {
            return nil
        }
    }
    
    @IBOutlet var textField: UITextField!
    
    @IBAction func fahrenheitFieldEditingChanged(_ textField: UITextField) {
        if let text = textField.text, let value = Double(text) {
            fahrenheitValue = Measurement(value: value, unit: .fahrenheit)
        } else {
            fahrenheitValue = nil
        }
    }
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        textField.resignFirstResponder()
    }
    
    func updateCelsiusLabel() {
        if let celsiusValue = celsiusValue {
            celsiusLabel.text = numberFormatter.string(from: NSNumber(value: celsiusValue.value))
        } else {
            celsiusLabel.text = "???"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("ConversionViewController loaded its view")
        updateCelsiusLabel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        var color: UIColor
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH"
        let currentTime = dateFormatter.string(from: date)
        if Int(currentTime)! > 6 && Int(currentTime)! < 18 {
            color = UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)
        } else {
            color = UIColor(red: 0.25, green: 0.25, blue: 0.25, alpha: 1)
        }
        view.backgroundColor = color
    }
    
    let numberFormatter: NumberFormatter = {
        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        nf.minimumFractionDigits = 0
        nf.maximumFractionDigits = 1
        return nf }()
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let existingTextHasDecimalSeparator = textField.text?.range(of: ".")
        let replacementTextHasDecimalSeparator = string.range(of: ".")
        if existingTextHasDecimalSeparator != nil, replacementTextHasDecimalSeparator != nil {
            return false
            } else {
            return true
        }
    }

    
    
}
