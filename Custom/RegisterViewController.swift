//
//  RegisterViewController.swift
//  Custom
//
//  Created by 竹村明日香 on 2020/05/23.
//  Copyright © 2020 Takemura assan. All rights reserved.
//

import UIKit
import RealmSwift

class RegisterViewController: UIViewController {
    
    @IBOutlet var regiTextField: UITextField!
    var regizyo = String()
    
    
    let realm = try! Realm()
    let register = try! Realm().objects(Register.self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func regi(){
        
        if regiTextField.text == ""{
            self.dismiss(animated: true, completion: nil)
            let alert = UIAlertController(title: "何も入力されていません", message: "習慣を入力してください！！", preferredStyle: .alert)
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self.dismiss(animated: true, completion: nil)
            }
            self.present(alert, animated: true, completion:nil)
        }else{
            self.performSegue(withIdentifier: "TargetViewController", sender: nil)
        }
        
        regizyo.append(regiTextField.text!)
        UserDefaults.standard.set( regizyo, forKey: "regizyouhou" )
        
    }
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}

