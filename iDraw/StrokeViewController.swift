//
//  ViewController.swift
//  iDraw
//
//  Created by paw daw on 14/04/16.
//  Copyright © 2016 paw daw. All rights reserved.
//

import UIKit

protocol StrokeViewControllerDelegate {
    func strokeWidthChanged(width: CGFloat)
}

// UIView subclass for drawing the sample line
class SampleLineView: UIView {
    var sampleLine = UIBezierPath()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        let y = frame.height / 2
        sampleLine.moveToPoint(CGPointMake(10, y))
        sampleLine.addLineToPoint(CGPointMake(frame.width - 20, y))
    }
    
    override func drawRect(rect: CGRect) {
        UIColor.blackColor().setStroke()
        sampleLine.stroke()
    }
}

class StrokeViewController: UIViewController {
    
  
   
   
    @IBOutlet weak var strokeWidthSlider: UISlider!

    @IBOutlet weak var strokeWidthView: SampleLineView!
    
   
    var delegate: StrokeViewControllerDelegate?
    
    var strokeWidth: CGFloat = 10.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        strokeWidthSlider.value = Float(strokeWidth)
        drawLineWithThickness(strokeWidth)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func lineWidthChanged(sender: UISlider) {
        strokeWidth = CGFloat(sender.value)
        drawLineWithThickness(strokeWidth)
    }
   
    
    private func drawLineWithThickness(thickness: CGFloat) {
        strokeWidthView.sampleLine.lineWidth = thickness
        strokeWidthView.setNeedsDisplay()
    }
    
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation. Before we go to the ViewController (our destination), delegate changes the stroke;s width for us.
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (sender as? UIBarButtonItem)?.tag == 1 {
            self.delegate?.strokeWidthChanged(self.strokeWidth)
        }
    }
    

}
