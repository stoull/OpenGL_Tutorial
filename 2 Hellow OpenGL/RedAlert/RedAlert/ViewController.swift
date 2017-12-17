//
//  ViewController.swift
//  RedAlert
//
//  Created by Stoull Hut on 17/12/2017.
//  Copyright © 2017 CCApril. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var rVc: HUTViewController?
    var gVc: HUTViewController?
    var bVc: HUTViewController?
    var combinVc : HUTViewController?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EmbedRed" {
            rVc = segue.destination as? HUTViewController
            rVc?.rMult = 1.0
        }
        
        if segue.identifier == "EmbedGreen" {
            gVc = segue.destination as? HUTViewController
            gVc?.gMult = 1.0
        }
        
        if segue.identifier == "EmbedBlue" {
            bVc = segue.destination as? HUTViewController
            bVc?.bMult = 1.0
        }
        
        if segue.identifier == "EmbedThreeColor" {
            combinVc = segue.destination as? HUTViewController
            combinVc?.rMult = 1.0
            combinVc?.bMult = 1.0
            combinVc?.gMult = 1.0
        }
    }

    @IBAction func sliderViewValueDidChange(_ sender: UISlider) {
        rVc?.secsPerFlash = Double(sender.value)
        gVc?.secsPerFlash = Double(sender.value)
        bVc?.secsPerFlash = Double(sender.value)
        combinVc?.secsPerFlash = Double(sender.value)
    }
}
