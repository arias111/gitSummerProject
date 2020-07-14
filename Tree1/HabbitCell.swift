//
//  HabbitCell.swift
//  Tree1
//
//  Created by Рустем on 09.07.2020.
//  Copyright © 2020 Рустем. All rights reserved.
//

import UIKit

class HabbitCell: UICollectionViewCell {

  
   
    @IBOutlet weak var text: UILabel!
    @IBOutlet weak var color: UIView!
    var index:Int!
    
    var piority:Int!
    
//    если нажать на плашку
    @IBAction func pressHabbit(_ sender: Any) {
        let x = Tree.share
        x.saveData(name: x.userData.name, drops: x.userData.drops + piority, image: "", goodHabits: x.userData.goodHabits, badHabits: x.userData.badHabits)
    }
    
    @IBAction func doSettings(_ sender: Any) {
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
