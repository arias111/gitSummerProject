//
//  Tree.swift
//  Tree1
//
//  Created by Рустем on 11.07.2020.
//  Copyright © 2020 Рустем. All rights reserved.
//

import Foundation

class Tree{
    var test = ViewController()
    
//    все что сохронять о пользователе
    let defaults = UserDefaults.standard
    static let share = Tree()
    
    
//    структура
    struct dataU:Codable {
        var name:String
        var drops:Int
        var image:String
        var goodHabits:Int
        var badHabits:Int
    }
    
//    переменная
    var userData:dataU{

        get{
            if let data = defaults.value(forKey: "userData") as? Data{
                return try! PropertyListDecoder().decode(dataU.self, from: data)
            } else {
                return dataU(name: "", drops: 0, image: "image", goodHabits: 0, badHabits: 0)
            }
        }

        set{
            if let data = try? PropertyListEncoder().encode(newValue) {
            defaults.set(data, forKey: "userData")
            }
        }

    }
    
//    поменять
    func saveData(name:String, drops:Int, image:String, goodHabits:Int, badHabits:Int){
        let dat = dataU(name: name,drops: drops,image: image,goodHabits: goodHabits,badHabits: badHabits)
        userData = dat
    }
    
    func changeGood(number : Int) {
        Tree.share.saveData(name: Tree.share.userData.name, drops: Tree.share.userData.drops, image: Tree.share.userData.image, goodHabits: Tree.share.userData.goodHabits + number, badHabits: Tree.share.userData.badHabits)
    }
    func changeBad(number : Int) {
        Tree.share.saveData(name: Tree.share.userData.name, drops: Tree.share.userData.drops, image: Tree.share.userData.image, goodHabits: Tree.share.userData.goodHabits, badHabits: Tree.share.userData.badHabits + number)
    }
    func changeDrops(number : Int) {
        Tree.share.saveData(name: Tree.share.userData.name, drops: Tree.share.userData.drops + number, image: Tree.share.userData.image, goodHabits: Tree.share.userData.goodHabits, badHabits: Tree.share.userData.badHabits)
    }
}
