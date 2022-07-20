//
//  HabitsViewController.swift
//  MyHabits
//
//  Created by Nikita Gribin on 28.06.2022.
//

import UIKit

class HabitsViewController: UIViewController {
    
   // var habit: Habit?
    
    var layot: UICollectionViewFlowLayout = {

        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 22, left: 16, bottom: 0, right: 16)
        layout.scrollDirection = .vertical
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        return layout

    }()
    
   private lazy var collectionView: UICollectionView = {
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.layot)
        collectionView.register(ProgressCollectionViewCell.self,
                                forCellWithReuseIdentifier: "MyCell")
       collectionView.register(HabitCollectionViewCell.self, forCellWithReuseIdentifier: "HabitCell")
       collectionView.backgroundColor = UIColor(red: 0.949, green: 0.949, blue: 0.969, alpha: 1)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
        
        
    }()
    
    var infoParam: [Habit] = HabitsStore.shared.habits
   

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.prefersLargeTitles = true
        
        print(infoParam.count)

        
        setConstraints()
        
        collectionView.reloadData()
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        collectionView.reloadData()
        print(infoParam.count)
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func setConstraints() {
        
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
        
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        
        ])
        
    }
    
}

extension HabitsViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section == 0 {
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath) as! ProgressCollectionViewCell
                    cell.layer.cornerRadius = 6
                    cell.backgroundColor = .white
                    cell.clipsToBounds = true
                    cell.progress = HabitsStore.shared.todayProgress
                    cell.labelProgess.text = "\(Int((cell.progress ?? 0) * 100))%"
                     return cell
        } else {
        
                let habitCell = collectionView.dequeueReusableCell(withReuseIdentifier: "HabitCell", for: indexPath) as! HabitCollectionViewCell
                habitCell.layer.cornerRadius = 6
                habitCell.clipsToBounds = true
                habitCell.backgroundColor = .white

            let article = HabitsStore.shared.habits[indexPath.row]
            habitCell.setInf(article)
                return habitCell
            }
    
    }
    
    
    
    

    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch section {
                    
                case 0:
                    return 1
                case 1:
            return HabitsStore.shared.habits.count
                default:
                    return 0
                    
                }
        
    }
    
    
    
       func numberOfSections(in collectionView: UICollectionView) -> Int {
           
           return 2
           
       }
       
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout:
                        
        UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

    switch indexPath.section {
                
            case 0:
                var size = CGSize()
                size.width = (collectionView.frame.width - 34)
                size.height = 60
                return size
            case 1:
                var size = CGSize()
                size.width = (collectionView.frame.width - 34)
                size.height = 130
                return size
            default:
                return CGSize()
                
            }

        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section != 0 {
            let habit = HabitsStore.shared.habits[indexPath.item]
            performSegue(withIdentifier: "showVC", sender: habit)
           // performSegue(withIdentifier: "showRedactor", sender: habit)
            
            
           
            
           
                
             
          
            
           
                
            }
            
            
        
          
        }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
        
        if let habit = sender as? Habit {
                if segue.identifier == "showVC" {
                           let destination = segue.destination as? HabitDetailsViewController
                    print("ffffff")
                    destination?.title = habit.name
                } else {
            
           
   

}




}
    
    
    }
}
    
            
            
        
    
    

    


