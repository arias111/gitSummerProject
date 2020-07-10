//
//  ViewController.swift
//  Tree1
//
//  Created by Рустем on 09.07.2020.
//  Copyright © 2020 Рустем. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var habbits: UICollectionView!
    let cellID = "cellID"
    var allHab = ["Первая привычка","Вторая привычка","Третья привычка","Четвертая привычка","Пять пять","шестая привычка","седьмая привычка"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        habbits.dataSource = self
        habbits.delegate = self
//        если делать через .xib
      habbits.register(UINib(nibName: "HabbitCell", bundle: nil) , forCellWithReuseIdentifier: cellID)
    }
    

//    @IBAction func GoGoodHabbits(_ sender: Any) {
//        let newVC = storyboard?.instantiateViewController(withIdentifier: "NewHabbit") as! NewHabbit
//        newVC.GoodOrBad!.text! = "new new new"
//        self.present(newVC, animated: true, completion: nil)
//    }
//
//    @IBAction func GoBadHabbits(_ sender: Any) {
//    }
//
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GoToGood" {
        let newVC = segue.destination as! NewHabbit
            if newVC.GoodOrBad != nil {
               newVC.GoodOrBad.text = "Hi"
                print("do")
            } else {
                print("no")
            }
        }
    }
    
    @IBAction func GoGood(_ sender: Any) {
        performSegue(withIdentifier: "GoToGood", sender: nil)
    }
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (allHab.count > 8) {
            return 8;
        } else {
            return allHab.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! HabbitCell
        cell.text.text = allHab[indexPath.item]
        cell.color.backgroundColor = UIColor.red
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        размер всего экрана = 400 , промежутки = 5*10,
        return CGSize(width: 85, height: 70)
    }
    
    
}

