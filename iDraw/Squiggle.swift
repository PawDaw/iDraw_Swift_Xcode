//
//  AppDelegate.swift
//  iDraw
//
//  Created by paw daw on 14/04/16.
//  Copyright © 2016 paw daw. All rights reserved.
//

import UIKit

class Squiggle: UIBezierPath {
    
    private var color : UIColor
    

    // Configure the Squiggle's properties
    init(color: UIColor, strokeWidth: CGFloat){
        
        self.color = color
        super.init()
        super.lineWidth = strokeWidth
        super.lineCapStyle = CGLineCap.Round
        super.lineJoinStyle = CGLineJoin.Round
        
    }
    
    // Required init, ssaving app's data
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) is not implemented")
        
    }
    
    
    // set the Squiggl's color before drawing it
    override func stroke() {
        color.setStroke()
        super.stroke()
    }

}
