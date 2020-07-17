//
//  WelcomeViewController.swift
//  Tree1
//
//  Created by Evelina on 17.07.2020.
//  Copyright © 2020 Рустем. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBOutlet weak var textSetName: UITextField!
    
    @IBAction func buttonGiveName(_ sender: Any) {
        Tree.share.saveData(name: (textSetName?.text)!, drops: Tree.share.userData.drops, image: Tree.share.userData.image, goodHabits: Tree.share.userData.goodHabits, badHabits: Tree.share.userData.badHabits, isNewUser: Tree.share.userData.isNewUser)
    }
    

}
