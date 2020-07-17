//
//  Profil.swift
//  Tree1
//
//  Created by Рустем on 15.07.2020.
//  Copyright © 2020 Рустем. All rights reserved.
//

import UIKit

class Profil: UIViewController {
    
    
    @IBOutlet weak var textUsername: UITextField!
    @IBOutlet weak var textDrops: UILabel!
    @IBOutlet weak var textGoodHabits: UILabel!
    @IBOutlet weak var textBadHabits: UILabel!
    
     var tree:ViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       checkUsername()
        checkStatistics()
    }
    
     
            func checkUsername(){
               let username = Tree.share.userData.name
                textUsername?.text = username
            }
            
            func checkStatistics(){
                textGoodHabits?.text = "\(Tree.share.userData.goodHabits)"
                textBadHabits?.text = "\(Tree.share.userData.badHabits)"
                textDrops?.text = "\(Tree.share.userData.drops)"
            }
            
            
    //      кнопка сохранения изменения имени пользователя
            @IBAction func changeUsernameButton(_ sender: Any) {
                Tree.share.saveData(name: (textUsername?.text)!, drops: Tree.share.userData.drops, image: Tree.share.userData.image, goodHabits: Tree.share.userData.goodHabits, badHabits: Tree.share.userData.badHabits, isNewUser: false)
                dismiss(animated: true, completion: nil)
            }
    
    @IBAction func reset(_ sender: Any) {
        let defaults = UserDefaults.standard
        let alert = UIAlertController(title: "Внимание!", message: "Все данные удалятся", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Удалить", style: .destructive, handler: { action in
            defaults.removeObject(forKey: "GoodHabbitArray")
            defaults.removeObject(forKey: "BadHabbitArray")
            defaults.removeObject(forKey: "userData")
            defaults.set(0, forKey: "downDay")
            defaults.set(0, forKey: "upDay")
            self.checkUsername()
            self.checkStatistics()
            self.tree.refreshAll()
                                            }))
        alert.addAction(UIAlertAction(title: "Отменить", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}
