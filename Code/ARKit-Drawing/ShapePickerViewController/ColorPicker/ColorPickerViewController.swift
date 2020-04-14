//
//  ColorPickerViewController.swift
//  Notes
//
//  Created by Timofei Sikorski on 8/27/19.
//  Copyright © 2019 SikorskiIT. All rights reserved.
//

import UIKit

protocol ColorPickerDelegate: NSObjectProtocol {
    
    func colorSelected(selectedColor: UIColor?)
    
}

class ColorPickerViewController: UIViewController {

    @IBOutlet weak var selectedColorView: UIView!
    @IBOutlet weak var brightnessSlider: UISlider!
    @IBOutlet weak var gradientView: GradientView!
    
    weak var delegate: ColorPickerDelegate?
    var initialColor: UIColor?
    
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set color from previev VievController
        selectedColorView.backgroundColor = initialColor
        gradientView.delegate = self
        
    }
    
}

// MARK: - Actions
extension ColorPickerViewController {
    
    @IBAction func brightnessChanged(_ sender: UISlider) {
        let newBrightness = CGFloat(sender.value)
        let newColor = selectedColorView.backgroundColor?.withAlphaComponent(newBrightness)
        
        selectedColorView.backgroundColor = newColor
    }
    
    @IBAction func doneButtonTapped(_ sender: Any) {
        let color = self.selectedColorView.backgroundColor?.withAlphaComponent(CGFloat(brightnessSlider.value))
        delegate?.colorSelected(selectedColor: color)
    }
    
}

// MARK: - Public functions
extension ColorPickerViewController: GradientViewDelegate {
    
    static func storyboardInstance() -> ColorPickerViewController? {
        let storyboard = UIStoryboard(name: "ColorPicker", bundle: nil)
        return storyboard.instantiateInitialViewController() as? ColorPickerViewController
    }
    
    // MARK: GradientViewDelegate
    func colorChanged(newColor: UIColor) {
        let currentColorBrightness = CGFloat(self.brightnessSlider.value)
        let colorWithBrightness = newColor.withAlphaComponent(currentColorBrightness)
        self.selectedColorView.backgroundColor = colorWithBrightness
    }
    
}

