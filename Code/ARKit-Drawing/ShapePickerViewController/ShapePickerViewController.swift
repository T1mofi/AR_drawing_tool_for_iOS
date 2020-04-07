//
//  ShapePickerViewController.swift
//  ARKit-Drawing
//
//  Created by Anjey Novicki on 4/6/20.
//  Copyright © 2020 Chad Zeluff. All rights reserved.
//

import UIKit

protocol ShapePickerDelegate {
    func prepareToHide(loadNewShape: Bool)
}

class ShapePickerViewController: UIViewController {

    var delegate: ShapePickerDelegate?
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
}

// MARK: - Public Functions
extension ShapePickerViewController {
    
    // Create viewController from storyboard
    static func storyboardInstance() -> ShapePickerViewController? {
        let storyboard = UIStoryboard(name: String(describing: self), bundle: nil)
        return storyboard.instantiateInitialViewController() as? ShapePickerViewController
    }
    
}

// MARK: - UICollectionViewDelegate
extension ShapePickerViewController : UICollectionViewDelegate {
    
}
