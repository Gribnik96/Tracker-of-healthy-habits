//
//  InfoViewController.swift
//  MyHabits
//
//  Created by Nikita Gribin on 28.06.2022.
//

import UIKit

class InfoViewController: UIViewController {
    
    private var scrollView: UIScrollView = {
        
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
        
    }()
    
    private var labelTitle: UILabel = {
        
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.text = "Привычка за 21 день"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    
    private var label: UILabel = {
        
        let label = UILabel()
        label.text =
        
        """
        Прохождение этапов, за которые за 21 день вырабатывается привычка, подчиняется следующему алгоритму:
        
        1. Провести 1 день без обращения
        к старым привычкам, стараться вести себя так, как будто цель, загаданная
        в перспективу, находится на расстоянии шага.
        
        2. Выдержать 2 дня в прежнем состоянии самоконтроля.
        
        3. Отметить в дневнике первую неделю изменений и подвести первые итоги — что оказалось тяжело, что — легче,
        с чем еще предстоит серьезно бороться.
        
        4. Поздравить себя с прохождением первого серьезного порога в 21 день.
        За это время отказ от дурных наклонностей уже примет форму осознанного преодоления и человек сможет больше работать в сторону принятия положительных качеств.
        
        5. Держать планку 40 дней. Практикующий методику уже чувствует себя освободившимся от прошлого негатива и двигается в нужном направлении с хорошей динамикой.
        
        6. На 90-й день соблюдения техники все лишнее из «прошлой жизни» перестает напоминать о себе, и человек, оглянувшись назад, осознает себя полностью обновившимся.
        """
        
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Информация"
        
        setConstraint()
        
    }
    
    private func  setConstraint() {
        
        view.addSubview(scrollView)
        scrollView.addSubview(label)
        scrollView.addSubview(labelTitle)
        
        NSLayoutConstraint.activate([
            
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            labelTitle.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 22),
            labelTitle.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            
            label.topAnchor.constraint(equalTo: labelTitle.bottomAnchor, constant: 16),
            label.leadingAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            label.trailingAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            label.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
            
        ])
    }
}
