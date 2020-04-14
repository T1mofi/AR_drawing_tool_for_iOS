//
//  ShapePickerViewController.swift
//  ARKit-Drawing
//
//  Created by Anjey Novicki on 4/6/20.
//  Copyright © 2020 Chad Zeluff. All rights reserved.
//

import UIKit

enum Shape: String, CaseIterable {
    case box = "Box"
    case sphere = "Sphere"
    case cylinder = "Cylinder"
    case cone = "Cone"
    case torus = "Torus"
}

protocol ShapePickerDelegate: NSObjectProtocol {
    func prepareToHide(loadNewShape: Bool)
}

class ShapePickerViewController: UIViewController {

    @IBOutlet var colorView: UIView!
    @IBOutlet var sizeSegmentControl: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    weak var delegate: ShapePickerDelegate?
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let recognizer = UITapGestureRecognizer()
        recognizer.addTarget(self, action: #selector(goToEditColor(_:)))
        colorView.addGestureRecognizer(recognizer)
        colorView.layer.cornerRadius = 15
        colorView.clipsToBounds = true
        
        self.collectionView.register(UINib(nibName: "ShapeCollectionViewCell", bundle: nil),
                                     forCellWithReuseIdentifier: "ShapeCollectionViewCell")
        self.collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Base")
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
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
extension ShapePickerViewController : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Shape.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ShapeCollectionViewCell", for: indexPath) as! ShapeCollectionViewCell
        let shape = Shape.allCases[indexPath.item].rawValue
        
        cell.setupCell(shapeName: shape)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = UIScreen.main.bounds.width / 2 - 20
        return CGSize(width: size, height: size)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
    }
    
}
