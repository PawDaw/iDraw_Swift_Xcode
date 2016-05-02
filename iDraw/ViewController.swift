//
//  ViewController.swift
//  iDraw
//
//  Created by paw daw on 14/04/16.
//  Copyright © 2016 paw daw. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var doodleView: ViewDoodle!
    
    @IBAction func undoButtonPressed(sender: UIBarButtonItem) {
        doodleView.undo()
    }
    
    @IBAction func clearButtonPressed(sender: UIBarButtonItem) {
        
        displayEraseDialog()
        // doodleView.clear()
    }
    
    func displayEraseDialog(){
        let alertController = UIAlertController(title: "are you Sure ?", message: " Tab to delete Your doodle", preferredStyle: .Alert)
        let cancelAction = UIAlertAction(title: "cancel", style: .Cancel, handler: nil)
        
        alertController.addAction(cancelAction)
        
        let deleteAction = UIAlertAction(title: "Delete", style: .Default, handler: {(action) in self.doodleView.clear()})
        
        alertController.addAction(deleteAction)
        
        presentViewController(alertController, animated: true, completion: nil)
        
    }
    
    // motion SHAKE clear screen :-)
    
    override func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent?) {
        if motion == UIEventSubtype.MotionShake{
            displayEraseDialog()
        }
    }
    
    
    // Save an image to the picture library
    @IBAction func actionActionPressed(sender: UIBarButtonItem) {
        
        let itemToShare = ["Check out my Fantastic doodle", doodleView.image]
        let activityViewController = UIActivityViewController(activityItems: itemToShare, applicationActivities: nil)
        
        presentViewController(activityViewController, animated: true, completion: nil)
        
    }
    
    // func return to Doodle View used after cliked buttons "Done" or "Cancel" from Color or Stroke ViewController (EXIT  action seque)
    @IBAction func returnToDoodleView (segue: UIStoryboardSegue) {
        
    }
    
    // After identifying the segues, we implement our destination Views. We described, from where we take the value.
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showColorChooser" {
            
            // upcoming is set to NewViewController
            let destinationViewController = (segue.destinationViewController as! UINavigationController).viewControllers.first as! ColorViewController
            destinationViewController.delegate = self
            
            // the color property of ColorViewController is set.
            destinationViewController.color = self.doodleView.drawingColor
        }
        
        if segue.identifier == "showStrokeWidth" {
            let destinationViewController = (segue.destinationViewController as! UINavigationController).viewControllers.first as! StrokeViewController
            destinationViewController.delegate = self
            destinationViewController.strokeWidth = self.doodleView.strokeWidth
        }
    }
    
}

// Implementing two interfaces from ColorViewController and StrokeViewController.

extension ViewController: ColorViewControllerDelegate {
    func colorChanged(color: UIColor) {
        doodleView.drawingColor = color
    }
}

extension ViewController: StrokeViewControllerDelegate {
    func strokeWidthChanged(width: CGFloat) {
        doodleView.strokeWidth = width
    }
}


