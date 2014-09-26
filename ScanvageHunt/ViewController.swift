//
//  ViewController.swift
//  ScanvageHunt
//
//  Created by Haodong Liu on 9/23/14.
//  Copyright (c) 2014 Haodong Liu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var createdItem: ScavengerHuntItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func cancel(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBOutlet weak var textField: UITextField!
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "DoneItem"{
            if let name = textField.text{
                if !name.isEmpty{
                    createdItem = ScavengerHuntItem(name: name)
        
                }
            }
        }
    }
}

