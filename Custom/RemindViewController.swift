//
//  RemindViewController.swift
//  Custom
//
//  Created by 竹村明日香 on 2020/05/23.
//  Copyright © 2020 Takemura assan. All rights reserved.
//

import UIKit
import RealmSwift

class RemindViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var remiTextField: UITextField!
    
    //    var datePicker: UIDatePicker = UIDatePicker()
    
    let realm = try! Realm()
    let register = try! Realm().objects(Register.self)
    
    let datePicker: UIDatePicker = {
        let dp = UIDatePicker()
        dp.datePickerMode = UIDatePicker.Mode.dateAndTime
        dp.timeZone = NSTimeZone.local
        dp.locale = Locale.current
        dp.addTarget(self, action: #selector(dateChange), for: .valueChanged)
        return dp
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        
        remiTextField.inputView = datePicker
        
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 35))
        let spacelItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dateChange))
        toolbar.setItems([spacelItem, doneItem], animated: true)
        
        remiTextField.inputView = datePicker
        remiTextField.inputAccessoryView = toolbar
        
        remiTextField.delegate = self
        
        // Do any additional setup after loading the view.
    }
    
    @objc func dateChange(){
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd hh:mm"
        remiTextField.text = "\(formatter.string(from: datePicker.date))"
        
    }
    
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        return false
    }
    
    
    @IBAction func remi(){
        let newRegister = Register()
        newRegister.remi = remiTextField.text!
        
        try! realm.write{
            realm.add(newRegister)
        }
        
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
