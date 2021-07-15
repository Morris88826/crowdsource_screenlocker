//
//  CrowdsourceViewController.swift
//  crowdsource_screenlocker
//
//  Created by Morris Tseng on 2021/7/15.
//

import UIKit

class CrowdsourceViewController: UIViewController {

    @IBOutlet weak var card: UIView!
    public var start: ((Bool?) -> Void)?
    private var center_y: CGFloat?
    @IBOutlet weak var no_label: UILabel!
    @IBOutlet weak var yes_label: UILabel!
    @IBOutlet weak var skip_label: UILabel!
    
    private var once: Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        center_y = view.center.y
        self.once = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if isBeingDismissed {
            start?(false)
        }
    }

    @IBAction func swiping(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)
        
        let _y = min(self.center_y! + translation.y, self.center_y!)
        self.card.center = CGPoint(x: view.center.x + translation.x, y: _y)
        
        if translation.x > 100{
            
            self.yes_label.text = "Yes"
            self.yes_label.textColor = .green

            if (translation.x > 250) && (!self.once!){
                print("Yes")
                self.open_unlock_page()
                self.once! = true
            }
            
        }
        else if translation.x < -100{
            
            self.no_label.text = "No"
            self.no_label.textColor = .red

            if (translation.x < -250) && (!self.once!){
                print("No")
                self.open_unlock_page()
                self.once! = true
            }
        }
        else if translation.y < -100{
            print("Skip")
            self.skip_label.text = "Skip"
            self.skip_label.textColor = .blue

            if (translation.y < -300) && (!self.once!){
                print("Skip")
                self.open_unlock_page()
                self.once! = true
            }
        }
    
        if sender.state == .ended{
            UIView.animate(withDuration: 0.2, animations: {
                self.card.center = CGPoint(x: self.view.center.x, y:self.center_y!)
            })
            self.yes_label.text = ""
            self.no_label.text = ""
            self.skip_label.text = ""
            
        }
    }
    @IBAction func clickYes(_ sender: UIButton) {
        print("Yes")
        self.open_unlock_page()
    }
    
    @IBAction func clickSkip(_ sender: UIButton) {
        print("Skip")
        self.open_unlock_page()
    }
    
    @IBAction func ckickNo(_ sender: UIButton) {
        print("No")
        self.open_unlock_page()
    }
    
    func open_unlock_page(){
        
        let unlock_entry = storyboard?.instantiateViewController(identifier: "unlock_vc") as! UnlockViewController
    
        unlock_entry.modalPresentationStyle = .fullScreen
        
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromBottom
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
        view.window!.layer.add(transition, forKey: kCATransition)
        
        present(unlock_entry, animated: false)
    }
    
}
