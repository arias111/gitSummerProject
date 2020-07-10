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
    
    var textHab:String!
    
    var habbit:(name: String,Priority: Int)!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
//       присвоем текст наверху который
        GoodOrBad.text = textHab
    }
    
//    создает новую привычку
    @IBAction func Do(_ sender: Any) {
        if NameHabbit.text != nil {
        habbit = (NameHabbit.text!,PriorityHabbit.selectedSegmentIndex)
            print(habbit!)
        }
    }

}
