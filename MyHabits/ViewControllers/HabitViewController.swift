//
//  HabitViewController.swift
//  MyHabits
//
//  Created by Nikita Gribin on 28.06.2022.
//

import UIKit

class HabitViewController: UIViewController, UIColorPickerViewControllerDelegate,UITextFieldDelegate {
    
    var habit: Habit?
    
    var nameLabel: UILabel = {
        
        let  label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .bold)
        label.text = "НАЗВАНИЕ"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    
  lazy  var nameTextField: UITextField = {
        
        let textField = UITextField()
        textField.font = .systemFont(ofSize: 17)
        textField.placeholder = "Бегать по утрам, спать 8 часов и т.п."
        textField.delegate = self
        textField.resignFirstResponder()
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
        
    }()
    
    var colorLabel: UILabel = {
        
        let  label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .bold)
        label.text = "ЦВЕТ"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    
    var colorView: UIButton = {
        
        let button = UIButton()
        button.backgroundColor = .red
        button.frame.size.width = 30
        button.layer.cornerRadius = button.frame.size.width / 2
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(setColor), for: .touchUpInside)
        return button
        
    }()
    
    var timeLabel: UILabel = {
        
        let  label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .bold)
        label.text = "ВРЕМЯ"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    
    
    
    var contentLabel: UILabel = {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm a"
        let  label = UILabel()
        label.font = .systemFont(ofSize: 17 )
        label.text = "Каждый день в \(formatter.string(from: Date()))"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    
    var datePicker: UIDatePicker = {
        
        let datePicker = UIDatePicker()
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .time
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.addTarget(self, action: #selector(setTime(date:)), for: .valueChanged)
        return datePicker
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        colorText(date: datePicker)
        setConstraints()
        
        
    }
    
    func setConstraints() {
        
        view.addSubview(nameLabel)
        view.addSubview(nameTextField)
        view.addSubview(colorLabel)
        view.addSubview(colorView)
        view.addSubview(timeLabel)
        view.addSubview(contentLabel)
        view.addSubview(datePicker)
        
        NSLayoutConstraint.activate([
            
            nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 21),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            nameTextField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 7),
            nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            
            colorLabel.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 15),
            colorLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            colorView.topAnchor.constraint(equalTo: colorLabel.bottomAnchor, constant: 7),
            colorView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            colorView.widthAnchor.constraint(equalToConstant: 30),
            colorView.heightAnchor.constraint(equalToConstant: 30),
            
            timeLabel.topAnchor.constraint(equalTo: colorView.bottomAnchor, constant: 15),
            timeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            contentLabel.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 7),
            contentLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            datePicker.topAnchor.constraint(equalTo: contentLabel.bottomAnchor,constant: 15),
            datePicker.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            
        ])
    }
    
    func colorText(date: UIDatePicker) {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm a"
        let main_string = "Каждый день в \(formatter.string(from: date.date))"
        let string_to_color = "\(formatter.string(from: date.date))"
        let range = (main_string as NSString).range(of: string_to_color)
        let attribute = NSMutableAttributedString.init(string: main_string)
        attribute.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor(red: 161/255, green: 22/255, blue: 204/255, alpha: 1) , range: range)
        contentLabel.attributedText = attribute
    }
    
    @objc func setTime(date: UIDatePicker) {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm a"
        contentLabel.text = "Каждый день в \(formatter.string(from: date.date))"
        colorText(date: date)
        
    }
  
    @objc func setColor() {
        
        let colorPicker = UIColorPickerViewController()
        colorPicker.delegate = self
        present(colorPicker, animated: true, completion: nil)
    
    }
    
    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
        let color = viewController.selectedColor
        colorView.backgroundColor = color
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    @IBAction func close(_ sender: Any) {
        navigationController?.popViewController(animated: true)

        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveHabit(_ sender: Any) {
        
        
        let newHabit = Habit(name: nameTextField.text ?? "Error",
                             date:  datePicker.date,
                             color: colorView.backgroundColor!)
        let store = HabitsStore.shared
     
            
            store.habits.append(newHabit)
           
        
        
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    
    
}


