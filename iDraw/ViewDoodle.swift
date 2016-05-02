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
    var drawingColor: UIColor = UIColor.yellowColor()
    
    private var finishedSquiggles = [Squiggle]()
    private var currentSquiggle = [UITouch: Squiggle]()
    
    
    //required init
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
        self.multipleTouchEnabled = true
        
    }
    
    // deaw the completed lines ( squiggles ) and the current one
    
    override func drawRect(rect: CGRect) {
        for squiggle in finishedSquiggles {
            squiggle.stroke()
        }
        for squiggle in currentSquiggle.values{
            squiggle.stroke()
        }
        
    }
    
    // add a new line to the disctionary currentSquiggles
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
    
        // go thoud on all touches
        for touch in touches{
            let squiggle = Squiggle(color: drawingColor, strokeWidth: strokeWidth)
            squiggle.moveToPoint(touch.locationInView(self))
            currentSquiggle[touch] = squiggle
        }
    }
    
    // update the currentSquiggles dictionary
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        for touch in touches{
            currentSquiggle[touch]?.addLineToPoint(touch.locationInView(self))
            setNeedsDisplay() // create pixels
        }
    }
    
    // adds the finished currentSquiggle to the finishedSquiggles Array
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        for touch in touches{
            if let squiggle = currentSquiggle[touch] {
                finishedSquiggles.append(squiggle)
            }
            
            currentSquiggle[touch] = nil  // reset current Squigle
        }
    }
    
    // if interrupted by the OS remove the in-progrss aquiggle
    override func touchesCancelled(touches: Set<UITouch>?, withEvent event: UIEvent?) {
        
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
        self.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        
        // Create an image from the current context

        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
        
        
        
        
    }
    
    
}
