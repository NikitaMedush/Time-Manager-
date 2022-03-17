//
//  Extension .swift
//  Time Manager
//
//  Created by admin on 12.03.22.
//

import Foundation
import UIKit

extension UIViewController {
    func alertDate(label: UILabel, completionHandler: @escaping (Int,Date) -> Void) {
        let alert = UIAlertController(title: "", message:  nil, preferredStyle: .actionSheet)
        
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        alert.view.addSubview(datePicker)
        
        let ok = UIAlertAction(title: "Ok", style: .cancel) {(action) in
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd.MM.yyyy"
            let dateString = dateFormatter.string(from: datePicker.date)
            
            let calendar = Calendar.current
            let component = calendar.dateComponents([.weekday], from: datePicker.date)
            guard let weekday = component.weekday else {
                return
            }
            let numberWeekday = weekday
            let date = datePicker.date
            completionHandler(numberWeekday, date)
            label.text = dateString
        }
        let cancel = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        alert.addAction(ok)
        alert.addAction(cancel)
        
        alert.view.heightAnchor.constraint(equalToConstant: 300).isActive = true
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.widthAnchor.constraint(equalTo: alert.view.widthAnchor).isActive = true
        datePicker.heightAnchor.constraint(equalToConstant: 160).isActive = true
        datePicker.topAnchor.constraint(equalTo: alert.view.topAnchor, constant: 20).isActive = true
        
        present(alert, animated: true, completion: nil)
    }
    
    func alertTime(label: UILabel, completionHandler: @escaping (Date) -> Void) {
        let alert = UIAlertController(title: "", message: nil, preferredStyle: .actionSheet)
        
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .time
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.locale = NSLocale(localeIdentifier: "Ru_ru") as Locale
        alert.view.addSubview(datePicker)
//        выставить констрейнты **************** 
        let ok = UIAlertAction(title: "Ok", style: .cancel) { (action) in
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH:mm"
            let timeString = dateFormatter.string(from: datePicker.date)
            let timeTask = datePicker.date
            completionHandler(timeTask)
            
            label.text = timeString 
        }
        let cancel = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        alert.addAction(ok)
        alert.addAction(cancel)
        
        alert.view.heightAnchor.constraint(equalToConstant: 300).isActive = true
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.widthAnchor.constraint(equalTo: alert.view.widthAnchor).isActive = true
        datePicker.heightAnchor.constraint(equalToConstant: 160).isActive = true
        datePicker.topAnchor.constraint(equalTo: alert.view.topAnchor, constant: 20).isActive = true
        
        present(alert, animated: true, completion: nil)
    }
    
    func alertForCellName(label: UILabel, name: String, placeholder: String, completionHandler: @escaping (String) -> Void) {
        let alert = UIAlertController(title: name, message: nil, preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .cancel) { (action) in
            let textFieldAlert = alert.textFields?.first
            guard let text = textFieldAlert?.text else {
                return
            }
            label.text = text
            completionHandler(text)
        }
        alert.addTextField { (textFieldAlert) in
            textFieldAlert.placeholder = placeholder
        }
        let cancel = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        alert.addAction(ok)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
    }
}
