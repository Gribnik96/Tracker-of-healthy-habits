//
//  RedactorViewController.swift
//  MyHabits
//
//  Created by Nikita Gribin on 18.07.2022.
//

import UIKit

protocol RedacrorViewDelegete: AnyObject {
    
    func notify()
    func habitTitleChanged(to title: String?)
    
}

class RedactorViewController: HabitViewController {
    
    weak var delegete: RedacrorViewDelegete?
    
    var isHabit: Habit?
    
   private let deleteButton: UIButton = {
        
        let delete = UIButton()
        delete.tintColor = .red
        delete.setTitle("Удалить привычку", for: .normal)
        delete.setTitleColor(.red, for: .normal)
        delete.translatesAutoresizingMaskIntoConstraints = false
        delete.addTarget(self, action: #selector(deleteHabit), for: .touchUpInside)
        return delete
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        view.addSubview(deleteButton)
        
        NSLayoutConstraint.activate([
            
            deleteButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            deleteButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16)
            
        ])
    }
    
    @objc func deleteHabit() {
        
        let store = HabitsStore.shared
        let alertController = UIAlertController(title: "Удалить привычку", message: "Вы хотите удалить привычку \"\(isHabit?.name ?? " ")\" ?", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Отмена", style: .default, handler: nil))
        alertController.addAction(UIAlertAction(title: "Удалить", style: .destructive, handler: { _ in
            store.habits.removeAll(where: {
                self.isHabit?.name == $0.name
            })
            
            self.dismiss(animated: true, completion: nil)
            self.delegete?.notify()
                }
            
        ))
        present(alertController, animated: true, completion: nil)
    }
    
    @IBAction override func saveHabit(_ sender: Any) {
        
        let newHabit = Habit(name: nameTextField.text ?? "Error",
                             date:  datePicker.date,
                             color: colorView.backgroundColor!)
        let store = HabitsStore.shared
        for (index, storageHabit) in store.habits.enumerated() {
            if storageHabit.name == isHabit?.name {
                newHabit.trackDates = storageHabit.trackDates
                store.habits[index] = newHabit
                isHabit? = newHabit
                navigationController?.popToRootViewController(animated: true)
                dismiss(animated: true, completion: nil)
            }
        }
        print("enter")
        delegete?.habitTitleChanged(to: isHabit?.name)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        habit?.name = isHabit!.name
    }
    
    @IBAction func closed(_ sender: UIBarButtonItem) {
        
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
        
    }
}
