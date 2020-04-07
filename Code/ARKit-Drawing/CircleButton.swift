//
//  CircleButton.swift
//  ARKit-Drawing
//
//  Created by Anjey Novicki on 4/6/20.
//  Copyright © 2020 Chad Zeluff. All rights reserved.
//

import UIKit

class CircleButton: UIButton {
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        let centerPoint: CGPoint = CGPoint(x: self.bounds.size.width/2, y: self.bounds.size.height/2)
        
        let distance: CGFloat = distanceFrom(centerPoint, to: point)
        
        if( distance > self.bounds.size.height / 2) {
            return false
        }
        return true
    }
    
    func distanceFrom(_ start: CGPoint, to end:CGPoint) -> CGFloat {
        let result: CGFloat = sqrt(pow(end.x - start.x, 2) + pow(end.y - start.y, 2))
        return result
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
