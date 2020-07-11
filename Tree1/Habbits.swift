//
//  Habbits.swift
//  Tree1
//
//  Created by Рустем on 11.07.2020.
//  Copyright © 2020 Рустем. All rights reserved.
//

import Foundation

class Habbits{
//    все чтобы работало сохраниние привычек
    let defaults = UserDefaults.standard
    static let share = Habbits()
    
//    одна првычка
    struct Habbit:Codable {
        var name:String
        var priority:Int
        var color:String
    }
    
//    массив из привычек
    var HabbitArray:[Habbit]{

        get{
            if let data = defaults.value(forKey: "HabbitArray") as? Data{
                return try! PropertyListDecoder().decode([Habbit].self, from: data)
            } else {
                return [Habbit]()
            }
        }

        set{
            if let data = try? PropertyListEncoder().encode(newValue) {
            defaults.set(data, forKey: "HabbitArray")
            }
        }

    }
    
//    добавление привычки в массив
    func saveHabbit(name:String, priority:Int, color:String){
        let habbit = Habbit(name: name,priority: priority,color: color)
        HabbitArray.insert(habbit, at: 0)
    }
}
