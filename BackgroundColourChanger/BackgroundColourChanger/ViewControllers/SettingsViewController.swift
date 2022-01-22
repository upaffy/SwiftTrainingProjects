//
//  ViewController.swift
//  BackgroundColourChanger
//
//  Created by Pavlentiy on 22.08.2021.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var paletteView: UIView!
    
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    
    @IBOutlet weak var redValueLabel: UILabel!
    @IBOutlet weak var greenValueLabel: UILabel!
    @IBOutlet weak var blueValueLabel: UILabel!
    
    @IBOutlet var redValueTF: UITextField!
    @IBOutlet var greenValueTF: UITextField!
    @IBOutlet var blueValueTF: UITextField!
    
    var delegate: SettingsViewControllerDelegate!
    var mainScreenColor: UIColor!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        redValueTF.delegate = self
        greenValueTF.delegate = self
        blueValueTF.delegate = self
        
        paletteView.layer.cornerRadius = 20
        
        addDoneButton(to: redValueTF, greenValueTF, blueValueTF)
        
        correspondMainScreenColor()
        changeColorsTextValues(for: redSlider, greenSlider, blueSlider)
    }
    
    @IBAction func rgbSlidersChanged(_ sender: UISlider) {
        changeColorsTextValues(for: sender)
        changeViewBackground()
    }
    
    @IBAction func doneButtonPressed() {
        guard let paletteViewColor = paletteView.backgroundColor else { return }
        delegate.changeMainBackgroundColor(to: paletteViewColor)
        
        dismiss(animated: true)
    }
}

// MARK: - Private Methods
extension SettingsViewController {
    
    private func changeViewBackground() {
        paletteView.backgroundColor = UIColor(
            red: CGFloat(redSlider.value),
            green: CGFloat(greenSlider.value),
            blue: CGFloat(blueSlider.value),
            alpha: 1
        )
    }
    
    private func changeColorsTextValues(for sliders: UISlider...) {
        
        for slider in sliders {
            switch slider {
            case redSlider:
                let redSliderString = makeString(from: slider)
                redValueTF.text = redSliderString
                redValueLabel.text = redSliderString
            case greenSlider:
                let greenSliderString = makeString(from: slider)
                greenValueTF.text = greenSliderString
                greenValueLabel.text = greenSliderString
            default:
                let blueSliderString = makeString(from: slider)
                blueValueTF.text = blueSliderString
                blueValueLabel.text = blueSliderString
            }
        }
    }
    
    private func makeString(from slider: UISlider) -> String {
        String(format: "%0.2f", slider.value)
    }
    
    private func correspondMainScreenColor() {
        let (r, g, b) = extractRGB(from: mainScreenColor)
        setValueToSliders(red: r, green: g, blue: b)
        changeViewBackground()
    }
    
    private func extractRGB(from viewColor: UIColor) -> (Float, Float, Float) {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var alpha: CGFloat = 0
        
        viewColor.getRed(&r, green: &g, blue: &b, alpha: &alpha)
        
        return (Float(r), Float(g), Float(b))
    }
    
    private func setValueToSliders(red: Float, green: Float, blue: Float) {
        redSlider.value = red
        greenSlider.value = green
        blueSlider.value = blue
    }
        
}

// MARK: - Work with input data
extension SettingsViewController: UITextFieldDelegate {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        let textFieldValue = Float(textField.text ?? "0") ?? 0
        
        switch textField {
        case redValueTF:
            redSlider.value = textFieldValue
            changeColorsTextValues(for: redSlider)
        case greenValueTF:
            greenSlider.value = textFieldValue
            changeColorsTextValues(for: greenSlider)
        default:
            blueSlider.value = textFieldValue
            changeColorsTextValues(for: blueSlider)
        }
        
        changeViewBackground()
    }
    
    func addDoneButton(to textFields: UITextField...) {
        for textField in textFields {
            let keypadToolbar = UIToolbar()
            
            let flexSpace = UIBarButtonItem(
                barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace,
                target: nil,
                action: nil
            )
            
            let doneButton = UIBarButtonItem(
                title: "Done",
                style: UIBarButtonItem.Style.done,
                target: textField,
                action: #selector(UITextField.resignFirstResponder)
            )
            
            keypadToolbar.items = [flexSpace, doneButton]

            keypadToolbar.sizeToFit()
            textField.inputAccessoryView = keypadToolbar
        }
    }
}

