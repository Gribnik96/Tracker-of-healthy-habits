//
//  HabitCollectionViewCell.swift
//  MyHabits
//
//  Created by Nikita Gribin on 04.07.2022.
//

import UIKit

class HabitCollectionViewCell: UICollectionViewCell, UIGestureRecognizerDelegate {
    
    
    var habit: Habit?
    
    var nameLabel: UILabel = {
        
        let label = UILabel()
        //   label.text = "Выпить стакан воды"
        // label.textColor = Habit.c
        label.numberOfLines = 2
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    
    var timeLabel: UILabel = {
        
        let label = UILabel()
        //label.text = "Каждый день в 7:30"
        label.font = .systemFont(ofSize: 12)
        label.textColor = .systemGray2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    
    var amountLabel: UILabel = {
        
        let label = UILabel()
        label.text = "Счетчик:"
        label.textColor = .systemGray
        label.font = .systemFont(ofSize: 13)
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    
    var imageView: UIImageView = {
        
        let imageView = UIImageView()
        //   imageView.image = UIImage(systemName: "checkmark.circle")
    //    imageView.layer.borderWidth = 2
        imageView.frame.size.width = 38
        imageView.layer.cornerRadius = imageView.frame.size.width / 2
        imageView.isUserInteractionEnabled = true
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
        
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setConstraints()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(clickHabitGesture))
        tapGesture.delegate = self
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(tapGesture)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setConstraints() {
        
        contentView.addSubview(nameLabel)
        contentView.addSubview(timeLabel)
        contentView.addSubview(amountLabel)
        contentView.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            nameLabel.widthAnchor.constraint(equalToConstant: 250),
            
            timeLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            timeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            amountLabel.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 30),
            amountLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            amountLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            
            imageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -25),
            imageView.widthAnchor.constraint(equalToConstant: 38),
            imageView.heightAnchor.constraint(equalToConstant: 38)
            
        ])
        
        
    }
    
    
    
    
    
    @objc func clickHabitGesture(gesture: UITapGestureRecognizer) {
        
        
        imageView.image = UIImage.init(systemName: "checkmark.circle.fill")
        
        if habit?.isAlreadyTakenToday == false {
                    
                    HabitsStore.shared.track(habit!)
            
        }
        
    }
        
        
        
        func setInf(_ habit: Habit?) {
            
            nameLabel.text = habit?.name
            timeLabel.text = habit?.dateString
            //   imageView.backgroundColor = habit?.color
            //imageView.layer.borderColor = habit?.color.cgColor
            imageView.tintColor = habit?.color
            amountLabel.text = "Счетчик: \(habit?.trackDates.count ?? 0)"
            nameLabel.textColor = habit?.color
            
            if habit?.isAlreadyTakenToday == true {
                            
                            imageView.image = UIImage.init(systemName: "checkmark.circle.fill")
                        } else {
                            imageView.image = UIImage.init(systemName: "circle")
                            
                        }
            
        }
        
        
}
    
    
    
    
    
    
    
    
