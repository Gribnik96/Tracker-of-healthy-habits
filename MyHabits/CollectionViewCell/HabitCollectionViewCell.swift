//
//  HabitCollectionViewCell.swift
//  MyHabits
//
//  Created by Nikita Gribin on 04.07.2022.
//

import UIKit

protocol HabitCollectionViewCellDelegate {
    
    func updateData()
    
}

class HabitCollectionViewCell: UICollectionViewCell, UIGestureRecognizerDelegate {
    
    var delegate: HabitCollectionViewCellDelegate?
    
    var habit: Habit?
    
    private var nameLabel: UILabel = {
        
        let label = UILabel()
        label.numberOfLines = 2
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    
    private var timeLabel: UILabel = {
        
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.textColor = .systemGray2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    
    private var amountLabel: UILabel = {
        
        let label = UILabel()
        label.text = "Счетчик:"
        label.textColor = .systemGray
        label.font = .systemFont(ofSize: 13)
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    
    private var imageView: UIImageView = {
        
        let imageView = UIImageView()
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
    
    
   private func setConstraints() {
        
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
        
        if habit?.isAlreadyTakenToday == false {
            HabitsStore.shared.track(habit!)
            delegate?.updateData()
        } else {
            HabitsStore.shared.untrack(habit!)
            delegate?.updateData()
        }
        
        
        print("enter")
    }
    
    func setInf(_ habit: Habit?) {
        
        self.habit = habit
        nameLabel.text = habit?.name
        timeLabel.text = habit?.dateString
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








