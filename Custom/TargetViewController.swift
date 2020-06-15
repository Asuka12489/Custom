//
//  TargetViewController.swift
//  Custom
//
//  Created by 竹村明日香 on 2020/05/23.
//  Copyright © 2020 Takemura assan. All rights reserved.
//

import UIKit
import RealmSwift

class TargetViewController: UIViewController {
    
    @IBOutlet var tageTextField: UITextField!
    var tagezyo = String()
    
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func tage(){
        
        if tageTextField.text == ""{
            self.dismiss(animated: true, completion: nil)
            let alert = UIAlertController(title: "何も入力されていません", message: "目標を立てよう！", preferredStyle: .alert)
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self.dismiss(animated: true, completion: nil)
            }
            self.present(alert, animated: true, completion:nil)
        }else{
            self.performSegue(withIdentifier: "RemindViewController", sender: nil)
        }
        
        tagezyo.append(tageTextField.text!)
        UserDefaults.standard.set( tagezyo, forKey: "tagezyouhou" )
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        performSegue(withIdentifier: "ViewController", sender: nil)
        
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
