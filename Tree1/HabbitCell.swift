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
    @IBOutlet weak var isCompleteImage: UIImageView!
    
    var index:Int!
    var piority:Int!
    var isDone: Bool?
    
    func configure() {
        if isDone == true {
            isCompleteImage.image = UIImage(named: "checkMark")
        } else {
            isCompleteImage.image = UIImage(named: "cross")
        }
    }

}
