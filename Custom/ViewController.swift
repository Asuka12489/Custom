//
//  ViewController.swift
//  Custom
//
//  Created by 竹村明日香 on 2020/05/23.
//  Copyright © 2020 Takemura assan. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var registerLabel: UILabel!
    @IBOutlet var targetLabel: UILabel!
    @IBOutlet var tableView: UITableView!
    
    let realm = try! Realm()
    let register = try! Realm().objects(Register.self)
    
    var notificationToken: NotificationToken?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        
        notificationToken = register.observe { [weak self] _ in self?.tableView.reloadData()
            
        }
        // Do any additional setup after loading the view.
    }
    
    @IBAction func memoButton(_ sender: Any) {
        var memoTextField = UITextField()
        let ac = UIAlertController(title: "記録しよう！", message: "", preferredStyle: .alert)
        let aa = UIAlertAction(title: "OK", style: .default) { (action) in
            let newRegister = Register()
            newRegister.seco = memoTextField.text!
            
            try! self.realm.write(){
                self.realm.add(newRegister)
            }
        }
        
        ac.addTextField { (textField) in
            textField.placeholder = "今日は何した？"
            memoTextField = textField
        }
        ac.addAction(aa)
        present(ac, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        tableView.deleteRows(at: [indexPath], with: .automatic)
        
        
        //スワイプ削除
        let deleteAction = UIContextualAction(style: .destructive, title:"delete") {
            (ctxAction, view, completionHandler) in
            let newRegister = Register()
            try! self.realm.write() {
                self.realm.delete(newRegister)
            }
            tableView.deleteRows(at: [indexPath], with: .automatic)
            completionHandler(true)
            
        }
        
        let trashImage = UIImage(systemName: "trash")?.withTintColor(UIColor.white , renderingMode: .alwaysTemplate)
        deleteAction.image = trashImage
        deleteAction.backgroundColor = UIColor(red: 255/255, green: 0/255, blue: 0/255, alpha: 1)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return register.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell2", for: indexPath) as! SecondTableViewCell
        cell.kiroLabel.text = register[indexPath.row].seco
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let storyboard: UIStoryboard = self.storyboard!
        
        let third = storyboard.instantiateViewController(withIdentifier: "third")
        
        self.present(third, animated: true, completion: nil)
        
    }
    
}

