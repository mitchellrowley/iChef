//
//  ConversionViewController.swift
//  WorldTrotter
//
//  Created by Julien Esposito on 4/14/18.
//  Copyright © 2018 Julien Esposito. All rights reserved.
//

import UIKit

// protocols used for delegation are called "delegate protocols" and the naming
// convension for a delegate protocol is the name of the delegating class plus
// the word "Delegate"
class ConversionViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet var celsiusLabel: UILabel!
    var fahrenheitValue: Measurement<UnitTemperature>?
    // below adding a property observer
    {
        didSet
        {
            updateCelsiusLabel()
        }
    }
    
    // Now that ConversionViewController conforms to a "UITextFieldDelegate",
    // let's set the delegate property of the textfield (from julien: looks like an event handler to me, p. 83)
    func textField( _ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String ) ->Bool
    {
//        print( "Current text: \(textField.text)" )
//        print( "Replacement text: \(string)" )
//
        let existingTextHasDecimalSeparator = textField.text?.range( of: "." )
        let replacementTextHasDecimalSeparator = string.range(of: ".")
        
        if existingTextHasDecimalSeparator != nil, replacementTextHasDecimalSeparator != nil
        {
            return false
        }
        else
        {
            return true
        }
    }
    // computed property
    var celsiusValue: Measurement<UnitTemperature>?
    {
        if let fahrenheitValue = fahrenheitValue
        {
            return fahrenheitValue.converted( to: .celsius )
        }
        else
        {
            return nil
        }
    }
    
    // updates the celsiusLabel
    func updateCelsiusLabel() // method
    {
        if let celsiusValue = celsiusValue
        {
            //celsiusLabel.text = "\(celsiusValue.value)"
            celsiusLabel.text = numberFormatter.string(from: NSNumber(value: celsiusValue.value))
        }
        else
        {
            celsiusLabel.text = "???"
        }
    }
    @IBOutlet var textField: UITextField!
    
    @IBAction func fahrenheightFieldEditingChanged( _ textField: UITextField )
    {
        //celsiusLabel.text = textField.text
        
//        if let text = textField.text, !text.isEmpty {
//            celsiusLabel.text = text
//        } else {
//            celsiusLabel.text = "???"
//        }
        
        if let text = textField.text, let value = Double( text )
        {
            fahrenheitValue = Measurement( value: value, unit: .fahrenheit )
        }
        else
        {
            fahrenheitValue = nil
        }
    }
    
    @IBAction func dismissKeyboard( _ sender: UITapGestureRecognizer )
    {
        textField.resignFirstResponder()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateCelsiusLabel()
    }
    
    // using a closure to instanciate a number formatter
    let numberFormatter: NumberFormatter = {
        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        nf.minimumFractionDigits = 0
        nf.maximumFractionDigits = 1
        return nf
    }()
    
}
