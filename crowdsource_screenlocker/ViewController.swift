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
    
    var start = false


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
        
        let y_base = CGFloat(850)
        let _y = min(y_base, y_base+translation.y)
        
        if (_y < 600) && (!self.start){
            
            let crowdsource_entry = storyboard?.instantiateViewController(identifier: "crowdsource_vc") as! CrowdsourceViewController
            
            crowdsource_entry.modalPresentationStyle = .fullScreen
            crowdsource_entry.start = { [weak self] status in DispatchQueue.main.async {
                self?.start = status!
            }
            }
            
            present(crowdsource_entry, animated: true)
            self.start = true
            
        }
        
        if (!self.start) {
            bar.center = CGPoint(x: view.center.x, y: _y)
        }
        else{
            bar.center = CGPoint(x: view.center.x, y: y_base)
        }
        
        if sender.state == .ended{
            UIView.animate(withDuration: 0.2, animations: {
                bar.center = CGPoint(x: self.view.center.x, y:850)
            })
        }
    }
    

    
}

