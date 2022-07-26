//
//  HabitDetailsViewController.swift
//  MyHabits
//
//  Created by Nikita Gribin on 05.07.2022.
//

import UIKit

class HabitDetailsViewController: UIViewController {
    
    var habit: Habit?
    
    lazy var tableView: UITableView = {
        
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "DefaultCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.reloadData()
        setConstraints()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
        navigationController?.navigationBar.prefersLargeTitles = false
        
    }
    
    func setConstraints() {
        
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            
        ])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showRedactor" {
            let destinationNavController = segue.destination as? UINavigationController
            let destinationRedactorVC = destinationNavController?.viewControllers.first as? RedactorViewController
            destinationRedactorVC?.delegete = self
            
            destinationRedactorVC?.nameTextField.text = habit?.name
            destinationRedactorVC?.colorView.backgroundColor = habit?.color
            destinationRedactorVC?.datePicker.date = habit!.date
            destinationRedactorVC?.isHabit = habit
            
        }
    }
}

extension HabitDetailsViewController:  UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return HabitsStore.shared.dates.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "DefaultCell", for: indexPath)
        let formatter = DateFormatter()
        formatter.dateFormat = "ru Ru"
        cell.textLabel?.text = HabitsStore.shared.trackDateString(forIndex: indexPath.row)
        
        if let habit = habit {
            let date = HabitsStore.shared.dates[indexPath.row]
            if HabitsStore.shared.habit(habit, isTrackedIn: date) {
                cell.accessoryType = .checkmark
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        "Активность"
    }
}

extension HabitDetailsViewController: RedacrorViewDelegete {
    
    func notify() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    func habitTitleChanged(to title: String?) {
        self.title = title
    }
}

