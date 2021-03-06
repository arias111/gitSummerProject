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
    @IBOutlet weak var Erorr: UILabel!
    
    var tree:ViewController!
    
    var textHab:String!

    override func viewDidLoad() {
        super.viewDidLoad()
        
//       присвоем текст наверху который
        GoodOrBad.text = textHab
    }
    
//    создает новую привычку
    @IBAction func Do(_ sender: Any) {
        if NameHabbit.text == "" {
            Erorr.text = "Назовите привычку!"
            return
        }
        //f
        if GoodOrBad.text == "НОВАЯ ПОЛЕЗНАЯ ПРИВЫЧКA"{
            if (Habbits.share.GoodHabbitsArray.count >= 8){
                  Erorr.text = "Максимальное кол-во!"
                          return
            }
            Habbits.share.saveGoodHabbit(name: NameHabbit.text!, priority: PriorityHabbit.selectedSegmentIndex + 1, color: "red", date: "")
            print("create good")
        }
        if GoodOrBad.text == "НОВАЯ ВРЕДНАЯ ПРИВЫЧКA"{
            if (Habbits.share.BadHabbitsArray.count >= 8){
                  Erorr.text = "Слишком много вредных привычек!"
                          return
            }
            Habbits.share.saveBadHabbit(name: NameHabbit.text!, priority: (PriorityHabbit.selectedSegmentIndex + 1) * -1, color: "red", date: "")
            print("create bad")
        }
        tree.refreshAll()
        dismiss(animated: true, completion: nil)

    }

}
