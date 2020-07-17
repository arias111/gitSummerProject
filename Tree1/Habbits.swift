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
    struct Habbit: Codable {
        var name: String
        var priority: Int
        var color: String
        var date: String
        var isComplete: Bool
    }
    
    
    
//    массив хороших из привычек
    var GoodHabbitsArray:[Habbit]{

        get{
            if let data = defaults.value(forKey: "GoodHabbitArray") as? Data{
                return try! PropertyListDecoder().decode([Habbit].self, from: data)
            } else {
                return [Habbit]()
            }
        }
        set{
            if let data = try? PropertyListEncoder().encode(newValue) {
            defaults.set(data, forKey: "GoodHabbitArray")
            }
        }

    }
//    добавление хороших привычек в массив
    func saveGoodHabbit(name:String, priority:Int, color:String, date: String, isComplete: Bool){
        let habbit = Habbit(name: name,priority: priority,color: color, date: date, isComplete: isComplete)
        GoodHabbitsArray.append(habbit)
        Tree.share.changeGood(number: 1)
    }
    
    func deleteGoodHabbit(index: Int){
        GoodHabbitsArray.remove(at: index)
    }
    
    
    
    
    //    массив плохих из привычек
        var BadHabbitsArray:[Habbit]{

            get{
                if let data = defaults.value(forKey: "BadHabbitArray") as? Data{
                    return try! PropertyListDecoder().decode([Habbit].self, from: data)
                } else {
                    return [Habbit]()
                }
            }
            set{
                if let data = try? PropertyListEncoder().encode(newValue) {
                defaults.set(data, forKey: "BadHabbitArray")
                }
            }

        }
        
    //    добавление плохих привычки в массив
    func saveBadHabbit(name:String, priority:Int, color:String, date: String, isComplete: Bool){
        let habbit = Habbit(name: name,priority: priority,color: color, date: date, isComplete: isComplete)
            BadHabbitsArray.append(habbit)
            Tree.share.changeBad(number: 1)
        }
    
    func deleteBadHabbit(index: Int){
        BadHabbitsArray.remove(at: index)
    }
    
    }
