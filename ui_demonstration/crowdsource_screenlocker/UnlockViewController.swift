//
//  UnlockViewController.swift
//  crowdsource_screenlocker
//
//  Created by Morris Tseng on 2021/7/15.
//

import UIKit

class UnlockViewController: UIViewController {
    
    
    @IBOutlet weak var pin0: UIButton!
    @IBOutlet weak var pin1: UIButton!
    @IBOutlet weak var pin2: UIButton!
    @IBOutlet weak var pin3: UIButton!
    @IBOutlet weak var pin4: UIButton!
    @IBOutlet weak var pin5: UIButton!
    
    private var current_num_passcode = 0
    let passward = [8,8,0,8,2,6]
    var entered_passward: [Int] = []
    var my_pins: [UIButton] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.my_pins.append(self.pin0)
        self.my_pins.append(self.pin1)
        self.my_pins.append(self.pin2)
        self.my_pins.append(self.pin3)
        self.my_pins.append(self.pin4)
        self.my_pins.append(self.pin5)
        
        for pin in self.my_pins{
            pin.isEnabled = false
        }
    }
    
    private func update_pins(){
        if self.current_num_passcode == 0{
            for pin in self.my_pins{
                pin.setImage(UIImage(systemName: "circle"), for: .normal)
            }
            return
        }
        
        for i in 0...(self.current_num_passcode-1){
            self.my_pins[i].setImage(UIImage(systemName: "circle.fill"), for: .normal)
            self.my_pins[i].alpha = 1
            
        }
            
    }
    
    @IBAction func onCancel(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(identifier: "vc") as! ViewController
    
        vc.modalPresentationStyle = .fullScreen
        vc.start = false
        
        present(vc, animated: false)
    }
    
    private func check_passward(){
        
        self.current_num_passcode = self.entered_passward.count

        if (self.current_num_passcode == 6){
            if self.entered_passward == self.passward {

                let finish_entry = storyboard?.instantiateViewController(identifier: "finish_vc") as! FinishedViewController
            
                finish_entry.modalPresentationStyle = .fullScreen
                present(finish_entry, animated: false)
                
            } else {
                self.entered_passward = []
                self.current_num_passcode = 0
            }
        }
        
        self.update_pins()
    }
    
    @IBAction func click1(_ sender: UIButton) {
        self.entered_passward.append(1)
        self.check_passward()
    }
    
    @IBAction func click2(_ sender: UIButton) {
        self.entered_passward.append(2)
        self.check_passward()
    }
    
    @IBAction func click3(_ sender: UIButton) {
        self.entered_passward.append(3)
        self.check_passward()
    }
    
    @IBAction func click4(_ sender: UIButton) {
        self.entered_passward.append(4)
        self.check_passward()
    }
    
    @IBAction func click5(_ sender: UIButton) {
        self.entered_passward.append(5)
        self.check_passward()
    }
    
    @IBAction func click6(_ sender: UIButton) {
        self.entered_passward.append(6)
        self.check_passward()
    }
    
    @IBAction func click7(_ sender: UIButton) {
        self.entered_passward.append(7)
        self.check_passward()
    }
    
    @IBAction func click8(_ sender: UIButton) {
        self.entered_passward.append(8)
        self.check_passward()
    }
    
    @IBAction func click9(_ sender: UIButton) {
        self.entered_passward.append(9)
        self.check_passward()
    }
    
    @IBAction func click0(_ sender: UIButton) {
        self.entered_passward.append(0)
        self.check_passward()
    }
    
}


