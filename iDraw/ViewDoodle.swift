//
//  ViewController.swift
//  iDraw
//
//  Created by paw daw on 14/04/16.
//  Copyright © 2016 paw daw. All rights reserved.
//

import UIKit

class ViewDoodle: UIView {

    var strokeWidth : CGFloat = 10.0
    var drawingColor: UIColor = UIColor.yellow
    
    fileprivate var finishedSquiggles = [Squiggle]()
    fileprivate var currentSquiggle = [UITouch: Squiggle]()
    
    
    //required init
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
        self.isMultipleTouchEnabled = true
        
    }
    
    // deaw the completed lines ( squiggles ) and the current one
    
    override func draw(_ rect: CGRect) {
        for squiggle in finishedSquiggles {
            squiggle.stroke()
        }
        for squiggle in currentSquiggle.values{
            squiggle.stroke()
        }
        
    }
    
    // add a new line to the disctionary currentSquiggles
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    
        // go thoud on all touches
        for touch in touches{
            let squiggle = Squiggle(color: drawingColor, strokeWidth: strokeWidth)
            squiggle.move(to: touch.location(in: self))
            currentSquiggle[touch] = squiggle
        }
    }
    
    // update the currentSquiggles dictionary
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches{
            currentSquiggle[touch]?.addLine(to: touch.location(in: self))
            setNeedsDisplay() // create pixels
        }
    }
    
    // adds the finished currentSquiggle to the finishedSquiggles Array
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches{
            if let squiggle = currentSquiggle[touch] {
                finishedSquiggles.append(squiggle)
            }
            
            currentSquiggle[touch] = nil  // reset current Squigle
        }
    }
    
    // if interrupted by the OS remove the in-progrss aquiggle
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        currentSquiggle.removeAll()
    }
    
    // called from the viewController to undo last squiggle
    
    func undo() {
        finishedSquiggles.removeLast()
        setNeedsDisplay() // create pixels
    }
    
    // called from the viewController to remove all squiggles ( clear the screen)
    func clear(){
        finishedSquiggles.removeAll()
        setNeedsDisplay() // create pixels
    }
    
    // Retruns a UIimage of the DoodleView content ( Save context )
    var image: UIImage{
        // begin graphisimagecomtext with the size of the doodleView
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, true, 0.0)
        
        // render the doodleView's content into the created graphiscimagecontext
        self.layer.render(in: UIGraphicsGetCurrentContext()!)
        
        // Create an image from the current context

        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
        
        
        
        
    }
    
    
}
