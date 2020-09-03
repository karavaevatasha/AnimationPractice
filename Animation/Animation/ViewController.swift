//
//  ViewController.swift
//  Animation
//
//  Created by Nataliia on 02.09.2020.
//  Copyright © 2020 Natalia. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var animationSaver = 0
    
    // var changeSize = true
    
    @IBOutlet weak var squareView: UIView!
    @IBOutlet weak var widthView: NSLayoutConstraint!
    @IBOutlet weak var heightView: NSLayoutConstraint!
    
    @IBOutlet weak var numberLabel: UILabel!
    @IBAction func showPrevious(_ sender: Any) {
        animationSaver -= 1
        if animationSaver == 0 {
            animationSaver = 7
        }
        numberLabel.text = "\(animationSaver)"
    }
    @IBAction func showNext(_ sender: Any) {
        animationSaver += 1
        numberLabel.text = "\(animationSaver)"
        if animationSaver > 7 {
            animationSaver -= 1
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.squareView.backgroundColor = UIColor.red
        numberLabel.text = "0"
    }
    
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        
        squareView.layer.removeAllAnimations()
        
        switch animationSaver {
        //Изменение цвета фона квадрата на желтый
        case 1:
            UIView.animate(withDuration: 1, delay: 0, options: .autoreverse, animations: {
                self.squareView.backgroundColor = UIColor.yellow}, completion: { (isCompleted) in
                    self.squareView.backgroundColor = UIColor.red
            })
        // Перемещение в правый верхний угол экрана
        case 2:
            let f = self.squareView.frame
            UIView.animateKeyframes(withDuration: 1, delay: 0, options: .autoreverse,
                                    animations: {
                                        self.squareView.frame = CGRect(x: (UIScreen.main.bounds.size.width - self.squareView.frame.width), y: 0, width: self.squareView.frame.width, height: self.squareView.frame.height) }, completion: {
                                            (isCompleted) in
                                            self.squareView.frame = f
            })
        //  Закругление краев, чтобы он выглядел как круг
        case 3:
            let animate = CABasicAnimation(keyPath: "cornerRadius")
            animate.fromValue = NSNumber(value: 0)
            animate.toValue = NSNumber(value: Int(self.squareView.frame.size.width / 2))
            animate.duration = 1.0
            animate.autoreverses = true
            squareView.layer.add(animate, forKey: "cornerRadius")
            squareView.layer.cornerRadius = 0
            
            
        //  Поворот на 180 градусов
        case 4:
            UIView.animate(withDuration: 1, delay: 0, options: .autoreverse, animations: { self.squareView.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
            })
        //«Исчезание»
        case 5:
            UIView.animate(withDuration: 1, delay: 0, options: .autoreverse, animations: {
                self.squareView.alpha = 0 }, completion: { (isCompleted) in
                    self.squareView.alpha = 1
            })
        //Сначала увеличение в два раза, потом анимированное уменьшение обратно
        case 6:
            widthView.constant = 150
            heightView.constant = 150
            UIView.animateKeyframes(withDuration: 1, delay: 0, options: .autoreverse,
                                    animations: {
                                        self.widthView.constant = 300
                                        self.heightView.constant = 300
                                        self.view.layoutIfNeeded() }, completion: { (isCompleted) in
                                            self.widthView.constant = 150
                                            self.heightView.constant = 150
                                            self.view.layoutIfNeeded()
            })
        //Бесконечную анимацию поворота
        case 7:
            UIView.animate(withDuration: 1, delay: 0, options: [.autoreverse, .repeat], animations: { self.squareView.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
            })
        default:
            break
        }
    }
    
}
