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
    }
    
//    переменная
    var userData:dataU{

        get{
            if let data = defaults.value(forKey: "userData") as? Data{
                return try! PropertyListDecoder().decode(dataU.self, from: data)
            } else {
                return dataU(name: "", drops: 0, image: "image")
            }
        }

        set{
            if let data = try? PropertyListEncoder().encode(newValue) {
            defaults.set(data, forKey: "userData")
            }
        }

    }
    
//    поменять
    func saveData(name:String, drops:Int, image:String){
        let dat = dataU(name: name,drops: drops,image: image)
        userData = dat
    }
}
