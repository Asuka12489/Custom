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
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        tableView.deleteRows(at: [indexPath], with: .automatic)
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
        var alertController = UIAlertController()
        alertController = UIAlertController(title: "\(register[indexPath.row].regi)" ,message: "\(register[indexPath.row].kome)",preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "頑張った！!",style: .default,handler: nil))
        present(alertController, animated: true)
               
//        tableView.deselectRow(at: indexPath, animated: true)
//        let storyboard: UIStoryboard = self.storyboard!
//        let third = storyboard.instantiateViewController(withIdentifier: "third")
//        self.present(third, animated: true, completion: nil)
        
    }
    
}

