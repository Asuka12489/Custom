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
    
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func tage(){
        let newRegister = Register()
        newRegister.tage = tageTextField.text!

        try! realm.write{
            realm.add(newRegister)
        }
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
