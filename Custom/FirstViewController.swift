//
//  FirstViewController.swift
//  Custom
//
//  Created by 竹村明日香 on 2020/05/24.
//  Copyright © 2020 Takemura assan. All rights reserved.
//

import UIKit
import RealmSwift
import FSCalendar

class FirstViewController: UIViewController, UNUserNotificationCenterDelegate, FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance, UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        register.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! AddTableViewCell
        cell.customLabel.text = register[indexPath.row].regi
        return cell
    }
    
    
    @IBOutlet weak var calendar: FSCalendar!
    @IBOutlet var tableView: UITableView!
    
    let realm = try! Realm()
    var register = try! Realm().objects(Register.self)
    var notificationToken: NotificationToken?
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        calendar.dataSource = self
        calendar.delegate = self
        tableView.dataSource = self
        tableView.delegate = self
        
        if #available(iOS 10.0, *) {
            let center = UNUserNotificationCenter.current()
            center.requestAuthorization(options: [.badge, .sound, .alert], completionHandler: { (granted, error) in
                if error != nil {
                    return
                }
                if granted {
                    print("通知許可")
                    let center = UNUserNotificationCenter.current()
                    center.delegate = self
                } else {
                    print("通知拒否")
                }
            })
        } else {
            let settings = UIUserNotificationSettings(types: [.badge, .sound, .alert], categories: nil)
            UIApplication.shared.registerUserNotificationSettings(settings)
        }
        // Do any additional setup after loading the view.
        
        do {
            let realm = try Realm()
            register = realm.objects(Register.self)
        } catch {
        }
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            register.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! AddTableViewCell
            cell.customLabel.text = register[indexPath.row].regi
            return cell
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            
            tableView.deselectRow(at: indexPath, animated: true)
            let storyboard: UIStoryboard = self.storyboard!
            let second = storyboard.instantiateViewController(withIdentifier: "second")
            self.present(second, animated: true, completion: nil)
            
        }
        
        self.tableView.allowsSelection = false
        
        /*
         // MARK: - Navigation
         
         // In a storyboard-based application, you will often want to do a little preparation before navigation
         override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         // Get the new view controller using segue.destination.
         // Pass the selected object to the new view controller.
         }
         */
    }
    
    
    @IBAction func kiroku(){
        self.performSegue(withIdentifier: "ViewController", sender: nil)
    }
    
    func getDay(_ date:Date) -> (Int,Int,Int){
        let tmpCalendar = Calendar(identifier: .gregorian)
        let year = tmpCalendar.component(.year, from: date)
        let month = tmpCalendar.component(.month, from: date)
        let day = tmpCalendar.component(.day, from: date)
        return (year,month,day)
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition){
        var list: Results<Register>!
        do {
            let realm = try Realm()
            let predicate = NSPredicate(format: "%@ =< date AND date < %@", getBeginingAndEndOfDay(date).begining as CVarArg, getBeginingAndEndOfDay(date).end as CVarArg)
            list = realm.objects(Register.self).filter(predicate)
        } catch {
        }
        return list.count
        
        let selectDay = getDay(date)
        
    }
    
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int{
        return shouldShowEventDot
    }
    
    private func getBeginingAndEndOfDay(_ date:Date) -> (begining: Date , end: Date) {
        let begining = Calendar(identifier: .gregorian).startOfDay(for: date)
        let end = begining + 24*60*60
        return (begining, end)
    }
    
}

