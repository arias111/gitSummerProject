//
//  NewHabbit.swift
//  Tree1
//
//  Created by Рустем on 10.07.2020.
//  Copyright © 2020 Рустем. All rights reserved.
//

import UIKit

class NewHabbit: UIViewController {

    @IBOutlet weak var GoodOrBad: UILabel!
    @IBOutlet weak var NameHabbit: UITextField!
    @IBOutlet weak var PriorityHabbit: UISegmentedControl!
    
    var habbit:(name: String,Priority: Int) = ("",0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func Do(_ sender: Any) {
        
        if(PriorityHabbit.selectedSegmentIndex != 0) && (NameHabbit.text != nil){
        habbit = (NameHabbit.text!,PriorityHabbit.selectedSegmentIndex)
        }
    }

}
