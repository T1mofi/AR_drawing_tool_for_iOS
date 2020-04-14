//
//  ShapeCollectionViewCell.swift
//  ARKit-Drawing
//
//  Created by Anjey Novicki on 4/9/20.
//  Copyright © 2020 Chad Zeluff. All rights reserved.
//

import UIKit

class ShapeCollectionViewCell: UICollectionViewCell {

    static let reuseID = String(describing: ShapeCollectionViewCell.self)
    static let nib = UINib(nibName: String(describing: ShapeCollectionViewCell.self), bundle: nil)
       
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var ibImageView: UIImageView!
    @IBOutlet weak var ibLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //backgroundColor = .white
        clipsToBounds = true
        layer.cornerRadius = 5
        //clipsToBounds = true
        //view.backgroundColor = .red
        layer.borderWidth = 1
        layer.borderColor = UIColor.gray.cgColor
        ibLabel.font = UIFont.systemFont(ofSize: 18)
    }
    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        //updateContentStyle()
//    }
    
    func setupCell(shapeName: String) {
        let image = UIImage(named: shapeName)
        ibImageView.image = image
        ibLabel.text = shapeName
    }

}
