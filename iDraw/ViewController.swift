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
    
    @IBAction func undoButtonPressed(_ sender: UIBarButtonItem) {
        doodleView.undo()
    }
    
    @IBAction func clearButtonPressed(_ sender: UIBarButtonItem) {
        
        displayEraseDialog()
        // doodleView.clear()
    }
    
    func displayEraseDialog(){
        let alertController = UIAlertController(title: "are you Sure ?", message: " Tab to delete Your doodle", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "cancel", style: .cancel, handler: nil)
        
        alertController.addAction(cancelAction)
        
        let deleteAction = UIAlertAction(title: "Delete", style: .default, handler: {(action) in self.doodleView.clear()})
        
        alertController.addAction(deleteAction)
        
        present(alertController, animated: true, completion: nil)
        
    }
    
    // motion SHAKE clear screen :-)
    
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        if motion == UIEventSubtype.motionShake{
            displayEraseDialog()
        }
    }
    
    
    // Save an image to the picture library
    @IBAction func actionActionPressed(_ sender: UIBarButtonItem) {
        
        let itemToShare = ["Check out my Fantastic doodle", doodleView.image] as [Any]
        let activityViewController = UIActivityViewController(activityItems: itemToShare, applicationActivities: nil)
        
        present(activityViewController, animated: true, completion: nil)
        
    }
    
    // func return to Doodle View used after cliked buttons "Done" or "Cancel" from Color or Stroke ViewController (EXIT  action seque)
    @IBAction func returnToDoodleView (_ segue: UIStoryboardSegue) {
        
    }
    
    // After identifying the segues, we implement our destination Views. We described, from where we take the value.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showColorChooser" {
            
            // upcoming is set to NewViewController
            let destinationViewController = (segue.destination as! UINavigationController).viewControllers.first as! ColorViewController
            destinationViewController.delegate = self
            
            // the color property of ColorViewController is set.
            destinationViewController.color = self.doodleView.drawingColor
        }
        
        if segue.identifier == "showStrokeWidth" {
            let destinationViewController = (segue.destination as! UINavigationController).viewControllers.first as! StrokeViewController
            destinationViewController.delegate = self
            destinationViewController.strokeWidth = self.doodleView.strokeWidth
        }
    }
    
}

// Implementing two interfaces from ColorViewController and StrokeViewController.

extension ViewController: ColorViewControllerDelegate {
    func colorChanged(_ color: UIColor) {
        doodleView.drawingColor = color
    }
}

extension ViewController: StrokeViewControllerDelegate {
    func strokeWidthChanged(_ width: CGFloat) {
        doodleView.strokeWidth = width
    }
}


