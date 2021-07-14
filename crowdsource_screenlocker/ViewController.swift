//
//  ViewController.swift
//  crowdsource_screenlocker
//
//  Created by Morris Tseng on 2021/7/15.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!


    override func viewDidLoad() {
        super.viewDidLoad()
    
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true){ (_) in
            let date = Date()
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH:mm"
            let currentTime = dateFormatter.string(from: date)

            dateFormatter.dateFormat = "EEEE, MMMM d"
            let currentDate = dateFormatter.string(from: date)
            
            self.timeLabel.text = currentTime
            self.dateLabel.text = currentDate
        }
    
    }

    @IBAction func startUnlock(_ sender: UIPanGestureRecognizer) {
        
        let bar = sender.view!
        let translation = sender.translation(in: view)
        
        let _y = min(850, 850+translation.y)
        
        if _y < 600{
            print("change")
        }
        bar.center = CGPoint(x: view.center.x, y: _y)
        
        if sender.state == .ended{
            UIView.animate(withDuration: 0.2, animations: {
                bar.center = CGPoint(x: self.view.center.x, y:850)
            })
        }
    }
    

    
}

