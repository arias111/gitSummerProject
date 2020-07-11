//
//  ViewController.swift
//  Tree1
//
//  Created by Рустем on 09.07.2020.
//  Copyright © 2020 Рустем. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var habbitsTable: UICollectionView!
    let cellID = "cellID"
    let defaults = UserDefaults.standard
    
    @IBOutlet weak var drops: UILabel!
    
//    обновить
    @IBAction func refresh(_ sender: Any) {
        let x = Tree.share.userData.drops
        print("каплей: \(x)")
        drops.text = "Капель:\( x )"
        viewWillAppear(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        удаляю все данные перед проходом
        defaults.removeObject(forKey: "HabbitArray")
        defaults.synchronize()
        defaults.removeObject(forKey: "userData")
        defaults.synchronize()
        
//        задаю данные пользователя
        Tree.share.saveData(name: "Rustem", drops: 10, image: "")
        
//        для таблицы
        habbitsTable.dataSource = self
        habbitsTable.delegate = self
        
//        если делать через .xib
      habbitsTable.register(UINib(nibName: "HabbitCell", bundle: nil) , forCellWithReuseIdentifier: cellID)
    
    }
    
//    для перехода через +
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GoToGood" {
        let newVC = segue.destination as! NewHabbit
            newVC.textHab = "НОВАЯ ПОЛЕЗНАЯ ПРИВЫЧКA"
        }
        if segue.identifier == "GoToBad" {
        let newVC = segue.destination as! NewHabbit
            newVC.textHab = "НОВАЯ ВРЕДНАЯ ПРИВЫЧКA"
        }
    }
    
//    для обновления таблицы
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.habbitsTable.reloadData()
    }
    

    
    
}

//для плашек
extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{

//    количество плашек
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        UserDefaults.standard.synchronize()
        if (Habbits.share.HabbitArray.count >= 8) {
            return 8;
        } else {
            print(Habbits.share.HabbitArray.count)
            return Habbits.share.HabbitArray.count
        }
        
    }
    
//    для отображения плашек
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        UserDefaults.standard.synchronize()
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! HabbitCell
        cell.text.text = Habbits.share.HabbitArray[indexPath.item].name
        cell.color.backgroundColor = UIColor.red
//        зададам приоритет
        cell.piority = Habbits.share.HabbitArray[indexPath.item].priority
        return cell
    }
    
//    рамеры плашек
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        размер всего экрана = 400 , промежутки = 5*10,
        return CGSize(width: 85, height: 70)
    }
    
    
}

