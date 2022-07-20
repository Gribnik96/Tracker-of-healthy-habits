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
    
    init(_ habit: Habit) {
            self.habit = habit
            super.init(nibName: nil, bundle: nil)
        }

        required init?(coder: NSCoder) {
            super.init(coder: coder)
        }

    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
      
        setConstraints()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
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
        

//        if let isHabit = habit {
//
//                   if HabitsStore.shared.habit(isHabit, isTrackedIn: HabitsStore.shared.dates[HabitsStore.shared.dates.count - indexPath.row - 1]) {
//
//                       cell.accessoryType = .checkmark
//                       cell.tintColor = UIColor(named: "Purple")
//
//                   }
//               }
        if let habit = habit {
            let date = HabitsStore.shared.dates[indexPath.row]
            HabitsStore.shared.habit(habit, isTrackedIn: date)
        }

      
        
        
        
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        "Активность"
    }
    
}



