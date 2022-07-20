//
//  ProgressCollectionViewCell.swift
//  MyHabits
//
//  Created by Nikita Gribin on 30.06.2022.
//

import UIKit

class ProgressCollectionViewCell: UICollectionViewCell {
    
    var progress: Float? {
           
           didSet {
               
               progressView.progress = progress ?? 0
               
           }
       }
    
    var label: UILabel = {
        
        let label = UILabel()
        label.text = "Все получится!"
        label.textColor = .systemGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    
    var labelProgess: UILabel = {
        
        let label = UILabel()
        label.text = "50%"
        label.textColor = .systemGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    
    var progressView: UIProgressView = {
        
        let progressView = UIProgressView()
        progressView.progressTintColor = UIColor(named: "Purple")
        progressView.translatesAutoresizingMaskIntoConstraints = false
        
        return progressView
        
        
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        setConstraints()
        labelProgess.text = "\(Int(progressView.progress * 100))%"
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setConstraints() {
        
        contentView.addSubview(label)
        contentView.addSubview(labelProgess)
        contentView.addSubview(progressView)
        
        NSLayoutConstraint.activate([
        
            label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            
            labelProgess.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            labelProgess.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
        
            progressView.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 15),
            progressView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            progressView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            progressView.heightAnchor.constraint(equalToConstant: 7),
            progressView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15)
            
            
            
        ])
        
        
    }
    
    
    func setProgress(habit: Habit) {
        
        progressView.progress = HabitsStore.shared.todayProgress
        
    }
    
    
}
