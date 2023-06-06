//
//  ViewController.swift
//  RGB Hex Code Color Converter
//
//  Created by Ryan Mesa on 3/7/23.
// red="0.26051741839999998" green="0.2605243921" blue="0.260520637"

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var redTextField: UITextField!
    @IBOutlet weak var greenTextField: UITextField!
    @IBOutlet weak var blueTextField: UITextField!
    @IBOutlet weak var alphaTextField: UITextField!
    @IBOutlet weak var conversionButton: UIButton!
    @IBOutlet weak var resultsLabel: UILabel!
    
    enum Conversion {
        case hexToRGB
        case RGBToHex
    }
    var conversion: Conversion = .hexToRGB
    let startupBackgroundColor = UIColor(red: 0.26051741839999998, green: 0.2605243921, blue: 0.260520637, alpha: 1.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func selectSegmentAction(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
            case 0:
                conversion = .hexToRGB
                conversionButton.setTitle("Convert hex to RGB", for: .normal)
            case 1:
                conversion = .RGBToHex
                conversionButton.setTitle("Convert RGB to hex", for: .normal)
            default:
                conversion = .hexToRGB
                conversionButton.setTitle("Convert hex to RGB", for: .normal)
        }
        print(conversion)
        redTextField.text?.removeAll()
        greenTextField.text?.removeAll()
        blueTextField.text?.removeAll()
        alphaTextField.text?.removeAll()
    }
    
    @IBAction func convertAction(_ sender: UIButton) {
        switch conversion {
            case .hexToRGB:
                self.view.backgroundColor = convertHexToRGB()
            case .RGBToHex:
                self.view.backgroundColor = convertRGBToHex()
        }
    }
    
    func convertHexToRGB() -> UIColor? {
        guard let redText = UInt8(redTextField.text!, radix: 16) else { return nil }
        guard let greenText = UInt8(greenTextField.text!, radix: 16) else { return nil }
        guard let blueText = UInt8(blueTextField.text!, radix: 16) else { return nil }
        guard let alphaText = Float(alphaTextField.text!) else { return  nil }
        if alphaText > 1 || alphaText < 0 {
            return nil
        }
        
        print("Text entered: \(redText), \(greenText), \(blueText), \(alphaText)")
        resultsLabel.text = "Red: \(redText)\nGreen: \(greenText)\nBlue: \(blueText)\nAlpha: \(alphaText)"
        let backgroundColor = UIColor(red: CGFloat(redText) / 255, green: CGFloat(greenText) / 255, blue: CGFloat(blueText) / 255, alpha: CGFloat(alphaText))
        return backgroundColor
    }
    
    func convertRGBToHex() -> UIColor? {
        guard let redText = UInt8(redTextField.text!) else { return nil }
        guard let greenText = UInt8(greenTextField.text!) else { return nil }
        guard let blueText = UInt8(blueTextField.text!) else { return nil }
        guard let alphaText = Float(alphaTextField.text!) else { return  nil }
        if alphaText > 1 || alphaText < 0 {
            return nil
        }
        
        let redString = String(format: "%02X", redText)
        let greenString = String(format: "%02X", greenText)
        let blueString = String(format: "%02X", blueText)
        
        print("Text entered: \(redText), \(greenText), \(blueText), \(alphaText)")
        resultsLabel.text = "Hex code: #\(redString)\(greenString)\(blueString)\nAlpha: \(alphaText)"
        let backgroundColor = UIColor(red: CGFloat(redText) / 255, green: CGFloat(greenText) / 255, blue: CGFloat(blueText) / 255, alpha: CGFloat(alphaText))
        return backgroundColor
    }
    
    @IBAction func clearAction(_ sender: UIButton) {
        redTextField.text?.removeAll()
        greenTextField.text?.removeAll()
        blueTextField.text?.removeAll()
        alphaTextField.text?.removeAll()
        self.view.backgroundColor = startupBackgroundColor
        resultsLabel.text = "Result"
    }
}

