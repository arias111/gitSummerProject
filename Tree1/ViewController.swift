
import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var habbitsTableGood: UICollectionView!
    @IBOutlet weak var habbitsTableBad: UICollectionView!
    
    let cellIDGood = "cellIDGood"
    let cellIDBad = "cellIDBad"
    
    let defaults = UserDefaults.standard
    
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var weatherDegrees: UILabel!
    @IBOutlet weak var weatherText: UILabel!
    @IBOutlet weak var weatherVar: UILabel!
    
    @IBOutlet weak var vredText: UILabel!
    @IBOutlet weak var vredImage: UIImageView!
    
    let date = Date()
    let calendar = Calendar.current
    var minus = 0
    
    @IBOutlet weak var drops: UILabel!
    @IBOutlet weak var treeImage: UIImageView!
    
//    деревья
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
        habbitsTableGood.dataSource = self
        habbitsTableGood.delegate = self
        
        habbitsTableBad.dataSource = self
        habbitsTableBad.delegate = self
        
//        если делать через .xib
        habbitsTableGood.register(UINib(nibName: "HabbitCell", bundle: nil) , forCellWithReuseIdentifier: cellIDGood)
        habbitsTableBad.register(UINib(nibName: "HabbitCell", bundle: nil) , forCellWithReuseIdentifier: cellIDBad)
        
//        для погоды календарь
        let day = calendar.component(.day, from: date)
            let hour = calendar.component(.hour, from: date)
            let month = calendar.component(.month, from: date)
            minus = weatherDo(sender:day,hour:hour,month:month);
            weatherVar.text = String(minus)
            minus = minus + vredDo(day:day)
        Tree.share.userData.drops = Tree.share.userData.drops + minus
        
//        вызов дерева
        reloadTree()
    }
    
    // MARK: - Plus
    
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
        self.habbitsTableGood.reloadData()
        self.habbitsTableBad.reloadData()
    }
    
    // MARK: - Weather
//    погода
    func weatherDo(sender:Int,hour:Int,month:Int) -> Int{
        
//        какая погода
         let weather = (sender * (31-sender) * (13 - month))%30
        weatherDegrees.text = String(weather)
        
//        короткие дни
         var time:Int
        if((month > 9)&&(month < 4)){
            time = 14
        } else {
            time = 17
        }
        
//        цвет погоды
        if(hour > time) {
            weatherImage.image = UIImage(named: "weather-night")
        } else {
            weatherImage.image = UIImage(named: "weather-day")
        }
        
//        текст погоды
        switch weather {
        case 1...6:
            weatherText.text = "Холодная погода"
            return -0
        case 7...9:
            weatherText.text = "Холодная погода"
            return -1
        case 10...15:
            weatherText.text = "Прохладная погода"
            return -2
        case 16...21:
            weatherText.text = "Хорошая погода"
            return -3
        case 21...30:
            weatherText.text = "Жаркая погода"
            return -4
        default:
            weatherText.text = "Холодная погода"
            return -0;
        }
    }
    
    // MARK: - Vred
    
//    вредители
    func vredDo(day:Int) -> Int{
        let vred:Int
        
//        цвет вредителей
        switch day {
        case 9...13:
            vred = -2;
        default:
            vred = 0;
        }
        
//        текст вредителей
        if(vred == 0){
            vredText.text = "уже совсем  скоро"
            vredImage.image = UIImage(named: "noVred")
        } else {
            vredText.text = "начался -2💧"
            vredImage.image = UIImage(named: "yesVred")
        }
        return vred
    }
    
    
}

// MARK: - Habbits

//для плашек
extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{

//    количество плашек
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("goodArraycount1 \(Habbits.share.GoodHabbitsArray.count)")
        print("badArraycount1 \(Habbits.share.BadHabbitsArray.count)")
        
        if(collectionView == habbitsTableGood){
            print("GoodArraycount\(Habbits.share.GoodHabbitsArray.count)")
            if (Habbits.share.GoodHabbitsArray.count >= 8) {
            return 8;
        } else {
            return Habbits.share.GoodHabbitsArray.count
        }
        } else{
            print("badArraycount\(Habbits.share.BadHabbitsArray.count)")
            if (Habbits.share.BadHabbitsArray.count >= 8) {
                return 8;
            } else {
                return Habbits.share.BadHabbitsArray.count
            }
        }
    }
    
//    для отображения плашек
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if (collectionView == habbitsTableGood)&&(Habbits.share.GoodHabbitsArray.count != 0) {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIDGood, for: indexPath) as! HabbitCell
        cell.text.text = Habbits.share.GoodHabbitsArray[indexPath.item].name
        cell.color.backgroundColor = UIColor.green
//        зададам приоритет
        cell.piority = Habbits.share.GoodHabbitsArray[indexPath.item].priority
            print("good")
        return cell
        } else {
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIDBad, for: indexPath) as! HabbitCell
                    cell.text.text = Habbits.share.BadHabbitsArray[indexPath.item].name
                    cell.color.backgroundColor = UIColor.red
            //        зададам приоритет
                    cell.piority = Habbits.share.BadHabbitsArray[indexPath.item].priority
                    return cell
        }
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
           self.treeImage.image = self.listTree[index]
       }
    
    
    
}

