//
//  ViewController.swift
//  Tree1
//
//  Created by Рустем on 09.07.2020.
//  Copyright © 2020 Рустем. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var habbitsTableGood: UICollectionView?
    @IBOutlet weak var habbitTableBad: UICollectionView?
    
    let cellID = "cellID"
    let defaults = UserDefaults.standard
    
    
    @IBOutlet weak var textUsername: UITextField?
    @IBOutlet weak var textDrops: UILabel?
    @IBOutlet weak var textGoodHabits: UILabel?
    @IBOutlet weak var textBadHabits: UILabel?
    @IBOutlet weak var buttonChangeUsername: UIButton!
    
    @IBOutlet weak var weatherImage: UIImageView?
    @IBOutlet weak var weatherDegrees: UILabel?
    @IBOutlet weak var weatherText: UILabel?
    @IBOutlet weak var weatherVar: UILabel?
    
    @IBOutlet weak var vredText: UILabel?
    @IBOutlet weak var vredImage: UIImageView?
    
    let date = Date()
    let calendar = Calendar.current
    var minus = 0
    
    @IBOutlet weak var drops: UILabel!
    @IBOutlet weak var treeImage: UIImageView?
    
    var listTree: [UIImage?] = [
        UIImage(named: "tree#1"),
        UIImage(named: "tree#2"),
        UIImage(named: "tree#3"),
        UIImage(named: "tree#4"),
        UIImage(named: "tree#5"),
        UIImage(named: "tree#6")
    ]

//    обновить
    @IBAction func refresh(_ sender: Any) {
        let x = Tree.share.userData.drops
        reloadTree()
        print("каплей: \(x)")
        drops.text = "Капель:\( x )"
        changeDrops(number: x)
        viewWillAppear(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//      проверка данных в профиле и в user defaults
        checkStatistics()
        checkUsername()
        
//        удаляю все данные перед проходом
        defaults.removeObject(forKey: "HabbitArray")
        defaults.synchronize()
        defaults.removeObject(forKey: "userData")
        defaults.synchronize()
        
//        задаю данные пользователя
        Tree.share.saveData(name: "Rustem", drops: 10, image: "")
        
//        для таблицы
        habbitsTableGood?.dataSource = self
        habbitsTableGood?.delegate = self
        
//        если делать через .xib
        habbitsTableGood?.register(UINib(nibName: "HabbitCell", bundle: nil) , forCellWithReuseIdentifier: cellID)

        let day = calendar.component(.day, from: date)
            let hour = calendar.component(.hour, from: date)
            let month = calendar.component(.month, from: date)
            minus = weatherDo(sender:day,hour:hour,month:month);
        weatherVar?.text = String(minus)

            minus = minus + vredDo(day:day)

        Tree.share.userData.drops = Tree.share.userData.drops + minus
        reloadTree()
    }
    
//  очистить данные из профиля
    func cleanUpProfile(){
        changeDrops(number: 0)
        changeBad(number: 0)
        changeGood(number: 0)
        changeUserName(name: "  ")
    }
    
//  кнопка сохранения изменения имени пользователя
    @IBAction func changeUsernameButton(_ sender: Any) {
        changeUserName(name: (textUsername?.text)!)
       }
//  фунцкции проверяют правильность данных в профиле
    func checkUsername(){
        let username = defaults.value(forKey: "Username") as? String ?? " "
        textUsername?.text = username
    }
    
    func checkStatistics(){
        textGoodHabits?.text = "\(UserDefaults.standard.integer(forKey:"GoodHabits"))"
        textBadHabits?.text = "\(UserDefaults.standard.integer(forKey:"BadHabits"))"
        textDrops?.text = "\(UserDefaults.standard.integer(forKey:"Drops"))"
    }
    
//  функции изменяют данные в user defaults
    func changeUserName(name : String){
        defaults.set(name,forKey: "Username")
    }
    func changeGood(number : Int) {
        defaults.set(number, forKey: "GoodHabits")
    }
    func changeBad(number : Int) {
        defaults.set(number, forKey: "BadHabits")
    }
    func changeDrops(number : Int) {
        defaults.set(number, forKey: "Drops")
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
        self.habbitsTableGood?.reloadData()
    }
    
//    погода
    func weatherDo(sender:Int,hour:Int,month:Int) -> Int{
        //какая погода
         let weather = (sender * (31-sender) * (13 - month))%30
        weatherDegrees?.text = String(weather)
        
        //короткие дни
         var time:Int
        if((month > 9)&&(month < 4)){
            time = 14
        } else {
            time = 17
        }
        
        if(hour > time) {
            weatherImage?.image = UIImage(named: "weather-night")
            print("night")
        } else {
            weatherImage?.image = UIImage(named: "weather-day")
        print("day")
        }
        
        switch weather {
        case 1...6:
            weatherText?.text = "Холодная погода"
            return -0
        case 7...9:
            weatherText?.text = "Холодная погода"
            return -1
        case 10...15:
            weatherText?.text = "Прохладная погода"
            return -2
        case 16...21:
            weatherText?.text = "Хорошая погода"
            return -3
        case 21...30:
            weatherText?.text = "Жаркая погода"
            return -4
        default:
            weatherText?.text = "Холодная погода"
            return -0;
        }
    }
    
//    вредители
    func vredDo(day:Int) -> Int{
        let vred:Int
        switch day {
        case 9...13:
            vred = -2;
        default:
            vred = 0;
        }
        
        if(vred == 0){
            vredText?.text = "уже совсем  скоро"
            vredImage?.image = UIImage(named: "noVred")
        } else {
            vredText?.text = "начался -2💧"
            vredImage?.image = UIImage(named: "yesVred")
        }
        return vred
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
    
    // MARK: - Tree
                                    
//     выбор изображения дерева исходя из кол-ва капель
       func reloadTree()  {
        var index = 0
        let value = Tree.share.userData.drops
        switch value {
            
            case 0...10 :
                index = 0
            case 11...20 :
                index = 1
            case 21...30 :
                index = 2
            case 31...40 :
                index = 3
            case 41...50:
                index = 4
            case 51...INTPTR_MAX:
                index = 5
            
            default:
                index = 0
        }
        self.treeImage?.image = self.listTree[index]
       }
    
    
    
}

