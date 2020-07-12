//
//  ViewController.swift
//  Profile1
//
//  Created by Evelina on 11.07.2020.
//  Copyright © 2020 Evelina. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let userDefaults = UserDefaults.standard
    
    @IBOutlet weak var textUsername: UITextField?
    @IBOutlet weak var textGoodHabits: UILabel?
    @IBOutlet weak var textBadHabits: UILabel?
    @IBOutlet weak var textDrops: UILabel?
    @IBOutlet weak var buttonChangeUsername: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        checkStatistics()
        checkUsername()
    }
    
    func checkUsername(){
        let username = userDefaults.value(forKey: "Username") as? String ?? " "
        textUsername?.text = username
    }
    
    func checkStatistics(){
        textGoodHabits?.text = "\(UserDefaults.standard.integer(forKey:"GoodHabits"))"
        textBadHabits?.text = "\(UserDefaults.standard.integer(forKey:"BadHabits"))"
        textDrops?.text = "\(UserDefaults.standard.integer(forKey:"Drops"))"
    }

    @IBAction func changeUsernameButton(_ sender: Any) {
         changeUserName(name: (textUsername?.text)!)
    }
    
    func cleanUpProfile(){
        changeDrops(number: 0)
        changeBad(number: 0)
        changeGood(number: 0)
        changeUserName(name: "  ")
    }
    
    func changeUserName(name : String){
        userDefaults.set(name,forKey: "Username")
    }
    func changeGood(number : Int) {
        userDefaults.set(number, forKey: "GoodHabits")
    }
    func changeBad(number : Int) {
        userDefaults.set(number, forKey: "BadHabits")
    }
    func changeDrops(number : Int) {
        userDefaults.set(number, forKey: "Drops")
    }
}

