//
//  ShapePickerViewController.swift
//  ARKit-Drawing
//
//  Created by Anjey Novicki on 4/6/20.
//  Copyright © 2020 Chad Zeluff. All rights reserved.
//

import UIKit

protocol ShapePickerDelegate: NSObjectProtocol {
    func prepareToHide(loadNewShape: Bool)
}

class ShapePickerViewController: UIViewController {

    @IBOutlet var colorView: UIView!
    @IBOutlet var sizeSegmentControl: UIView!
    
    weak var delegate: ShapePickerDelegate?
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let recognizer = UITapGestureRecognizer()
        recognizer.addTarget(self, action: #selector(goToEditColor(_:)))
        colorView.addGestureRecognizer(recognizer)
    }

}

// MARK: - Actions
extension ShapePickerViewController {

  @IBAction func navigationButtonTapped(_ sender: UIBarButtonItem) {
        guard let delegate = delegate else {
            return
        }
        if sender.tag == 1 {
            delegate.prepareToHide(loadNewShape: true)
        } else {
            delegate.prepareToHide(loadNewShape: false)
        }
    }
    
    @objc func goToEditColor(_ gestureRecognizer: UITapGestureRecognizer) {
        guard let controller = ColorPickerViewController.storyboardInstance() else { return }
        controller.delegate = self
        self.present(controller, animated: true, completion: nil)
    }
}

// MARK: - Public Functions
extension ShapePickerViewController {
    
    // Create viewController from storyboard
    static func storyboardInstance() -> ShapePickerViewController? {
        let storyboard = UIStoryboard(name: String(describing: self), bundle: nil)
        return storyboard.instantiateInitialViewController() as? ShapePickerViewController
    }
    
}

// MARK: - Private Functions
fileprivate extension ShapePickerViewController {
   
}

// MARK: - ColorPickerDelegat
extension ShapePickerViewController: ColorPickerDelegate {
    func colorSelected(selectedColor: UIColor?) {
        if let color = selectedColor {
            self.colorView.backgroundColor = color
        }
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - UICollectionViewDelegate
extension ShapePickerViewController : UICollectionViewDelegate {
    
}
