//
//  ViewController.swift
//  math
//
//  Created by Admin on 07.04.2022.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        lbq.layer.cornerCurve = .circular
        lbq.layer.cornerRadius = 15
        generate()
    }
     var answ: Int = 0
     var task: Int = 0
    @IBOutlet weak var lbq: UIView!
    @IBOutlet weak var answlb: UILabel!
    @IBOutlet weak var tasklb: UILabel!
    @IBOutlet weak var btn1: UIButton!
    @IBOutlet weak var btncheck: UIButton!
    // @IBOutlet weak var checkbtn: UIButton!
   
    @IBAction func btnpress(_ sender: UIButton) {
       
        if sender.tag == 10
        {
            if answlb.text != ""
            {
                answlb.text?.removeLast()
            }
        }
        else{
            answlb.text = answlb.text! + String(sender.tag)
        }
        
    }

    @IBAction func checkbntpress(_ sender: UIButton) {
        let allertgood = UIAlertController(title: "Проверка ответа", message: "Верный ответ", preferredStyle: .alert)
        let okbtng = UIAlertAction(title: "Следующий пример", style: .default, handler: { action in
            self.generate()
            //print("поздравляю")
            
        }
        )
        allertgood.addAction(okbtng)
        
         
        let allertbad = UIAlertController(title: "Проверка ответа", message: "Неверный ответ", preferredStyle: .alert)
        let retry = UIAlertAction(title: "попробовать еще раз", style: .default, handler: { action in
            self.answlb.text = ""
            
        })
        let okbtnb = UIAlertAction(title: "Следующий пример", style: .default, handler: { action in
            self.generate()
            //print("поздравляю")
            
        }
        )
        allertbad.addAction(okbtnb)
        allertbad.addAction(retry)
        if answlb.text != ""
        {
            answ = Int(answlb.text!)!
        }
        else
        {
           
        }
        if task == answ
        {
            self.present(allertgood, animated: true)
                        
        }
        else
        {
            self.present(allertbad, animated: true)
            
        }
        
    }
          
    @objc public func generate ()
    {
        /*
        task = Int.random(in: 0...100)
        print(task)
        var lhr: Int = 0
        var rhr: Int = 0
        answlb.text = ""
        let randn = Int.random(in: 1...10)
        if task%2 == 0
        {
        lhr = task/2 - randn
        rhr = task/2 + randn
        }
        else
        {
            lhr = task/2 - randn
            rhr = task/2 + task%2 + randn
        }
        tasklb.text = "Решите пример:  \(lhr) + \(rhr)"
         */
        let sign = Int.random(in: 0...4)
        print(sign)
        var lhr = Int.random(in: 0...50)
        let rhr = Int.random(in: 1...50)
        answlb.text = ""
        
        switch sign
        {
        case 1:
            do {
                if lhr > rhr
                {
                task = lhr - rhr
                print(task)
                tasklb.text = "Решите пример:  \(lhr) - \(rhr)"
                }
                else
                {
                 task = rhr - lhr
                 print(task)
                 tasklb.text = "Решите пример:  \(rhr) - \(lhr)"
                }
            }
        case 2:
            do{
              task = lhr * rhr
              print(task)
              tasklb.text = "Решите пример:  \(lhr) * \(rhr)"
            }
        case 3:
            do{
                if (lhr % rhr) == 0
                {
                    task = lhr / rhr
                    print(task)
                    tasklb.text = "Решите пример:  \(lhr) / \(rhr)"
                }
                else{
                    while (lhr % rhr) != 0
                    {
                        lhr = Int.random(in: 0...50)
                    }
                    task = lhr / rhr
                    print(task)
                    tasklb.text = "Решите пример:  \(lhr) / \(rhr)"
                }
            }
        default:
            do{
                task = lhr + rhr
                print(task)
                tasklb.text = "Решите пример:  \(lhr) + \(rhr)"
            }
            
        }
    }
}


/*
{ action in
    self.generate()
    print("поздравляю")
    
}
*/
