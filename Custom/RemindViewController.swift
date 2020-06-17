//
//  RemindViewController.swift
//  Custom
//
//  Created by 竹村明日香 on 2020/05/23.
//  Copyright © 2020 Takemura assan. All rights reserved.
//

import UIKit
import RealmSwift

extension Date {
    func seconds(from date: Date) -> Int {
        return Calendar.current.dateComponents([.second], from: date, to: self).second ?? 0
    }
}

class RemindViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var remiTextField: UITextField!
    
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
        
        remiTextField.inputView = datePicker
        
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 35))
        let spacelItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
        toolbar.setItems([spacelItem, doneItem], animated: true)
        
        remiTextField.inputView = datePicker
        remiTextField.inputAccessoryView = toolbar
        
        remiTextField.delegate = self
        
    }
    
    @objc func done(){
        remiTextField.endEditing(true)
        let formatter = DateFormatter()
        formatter.dateFormat = "MM月dd日 hh:mm"
        remiTextField.text = "\(formatter.string(from: datePicker.date))"
        
    }
    
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        return false
    }
    
    
    @IBAction func remi(){
        
        setNotification(date: datePicker.date)
        
        if remiTextField.text == ""{
            self.dismiss(animated: true, completion: nil)
            let alert = UIAlertController(title: "選択されていません", message: "リマインド必要でしょ！", preferredStyle: .alert)
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self.dismiss(animated: true, completion: nil)
            }
            self.present(alert, animated: true, completion:nil)
        }else{
            navigationController?.popToViewController(navigationController!.viewControllers[0], animated: true)
        }
        
        UserDefaults.standard.integer(forKey: "tagezyouhou")
        
        let newRegister = Register()
        newRegister.remi = remiTextField.text!
        newRegister.regi =  UserDefaults.standard.string(forKey: "regizyouhou")!
        newRegister.tage =  UserDefaults.standard.string(forKey: "tagezyouhou")!
        
        try! realm.write{
            realm.add(newRegister)
        }
        
        
    }
    
    
    func setNotification(date: Date) {
        var trigger: UNNotificationTrigger
        
        let notificationTime = Calendar.current.dateComponents(in: TimeZone.current, from: date)
        let now = Date()
        let setDate = DateComponents(calendar: .current, year: notificationTime.year, month: notificationTime.month, day: notificationTime.day, hour: notificationTime.hour, minute: notificationTime.minute,second: notificationTime.second).date!
        
        let seconds = setDate.seconds(from: now)
        trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(seconds), repeats: false)
        
        let content = UNMutableNotificationContent()
        content.title = "記録しなくていいの？"
        content.sound = .default
        
        let identifier = NSUUID().uuidString
        
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
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
