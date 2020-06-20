//
//  KirokuViewController.swift
//  Custom
//
//  Created by 竹村明日香 on 2020/06/18.
//  Copyright © 2020 Takemura assan. All rights reserved.
//

import UIKit
import RealmSwift

class KirokuViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet var kiroTextField: UITextField!
    @IBOutlet var komeTextField: UITextField!
    
    let realm = try! Realm()
    let register = try! Realm().objects(Register.self)
    
    
    let datePicker: UIDatePicker = {
        let dp = UIDatePicker()
        dp.datePickerMode = UIDatePicker.Mode.dateAndTime
        dp.timeZone = NSTimeZone.local
        dp.locale = Locale.current
        dp.addTarget(self, action: #selector(done), for: .valueChanged)
        return dp
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        
        kiroTextField.inputView = datePicker
        
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 35))
        let spacelItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
        toolbar.setItems([spacelItem, doneItem], animated: true)
        
        kiroTextField.inputView = datePicker
        kiroTextField.inputAccessoryView = toolbar
        
        kiroTextField.delegate = self
        komeTextField.delegate = self
        
    
        // Do any additional setup after loading the view.
    }
    
    @objc func done(){
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy年MM月dd日"
        kiroTextField.text = "\(formatter.string(from: datePicker.date))"
        kiroTextField.endEditing(true)
        
    }
    
    @IBAction func kiroku(){
        let newRegister = Register()
        newRegister.seco = kiroTextField.text!
        newRegister.kome = komeTextField.text!
        
        try! self.realm.write(){
            self.realm.add(newRegister)
        }
        
        navigationController?.popToViewController(navigationController!.viewControllers[0], animated: true)
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        komeTextField.resignFirstResponder()
        return true
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
