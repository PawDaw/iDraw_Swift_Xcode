//
//  ViewController.swift
//  iDraw
//
//  Created by paw daw on 14/04/16.
//  Copyright © 2016 paw daw. All rights reserved.
//

import UIKit

// delegate protocol for the viewcontoller to confrom to

protocol ColorViewControllerDelegate {
    
    func colorChanged(_ color: UIColor)
}


class ColorViewController: UIViewController {
    
    var color = UIColor.black
    var delegate: ColorViewControllerDelegate?

    @IBOutlet weak var alphaSlider: UISlider!
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    
    @IBOutlet weak var colorView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var red: CGFloat = 0.0
        var green: CGFloat = 0.0
        var blue: CGFloat = 0.0
        var alpha: CGFloat = 0.0
        
        // & - return address of the vareable
        color.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        
        alphaSlider.value = Float(alpha)
        redSlider.value = Float(red)
        blueSlider.value = Float(blue)
        greenSlider.value = Float(green)
        
        
        colorView.backgroundColor = color
        
    }

    @IBAction func colorChanged(_ sender: UISlider) {
        
        colorView.backgroundColor = UIColor(red: CGFloat(redSlider.value), green: CGFloat(greenSlider.value), blue: CGFloat(blueSlider.value), alpha: CGFloat(alphaSlider.value))
        
        color = colorView.backgroundColor!
        
    }
    
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation. Before we go to the ViewController (our destination), delegate changes the color for us.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (sender as? UIBarButtonItem)?.tag == 1 {
            self.delegate?.colorChanged(self.color)
        }
    }
}
