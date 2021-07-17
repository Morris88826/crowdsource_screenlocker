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
    
    @IBOutlet weak var question: UILabel!
    @IBOutlet weak var image: UIImageView!
    
    private var once: Bool?
    public var type: Int?
    
    // Samples
    private var classification_examples = [
        ["question": "Does this image contain sky?",
            "name":"classification_01.png"
        ],
        ["question": "Does this image contain sky?",
            "name":"classification_02.png"
        ],
        ["question": "Does this image contain aquarium?",
            "name":"classification_03.png"
        ],
        ["question": "Does this image contain aquarium?",
            "name":"classification_04.png"
        ],
        ["question": "Does this image contain bride?",
            "name":"classification_05.png"
        ],
        ["question": "Does this image contain bride?",
            "name":"classification_06.png"
        ]
    ]

    private var caption_examples = [
        ["question": "crowned crane portrait",
            "name":"caption_01.png"
        ],
        ["question": "aerial view of the sea port",
            "name":"caption_02.png"
        ],
        ["question": "the app on a computer",
            "name":"caption_03.png"
        ],
        ["question": "handsome muscular man doing exercises in the park",
            "name":"caption_04.png"
        ],
        ["question": "a tourist attraction in the winter",
            "name":"caption_05.png"
        ]
    ]
    
    private var chart_examples = ["chart_01.png","chart_02.png","chart_03.png","chart_04.png","chart_05.png"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        center_y = view.center.y
        self.once = false

        switch self.type!{
        case 0:
            let id = Int.random(in: 0..<self.classification_examples.count)
            let question = self.classification_examples[id]["question"]
            let image_name = self.classification_examples[id]["name"]!
            self.question.text = question
            self.image.image = UIImage(named:image_name)
        case 1:
            let id = Int.random(in: 0..<self.caption_examples.count)
            let question = self.caption_examples[id]["question"]!
            let image_name = self.caption_examples[id]["name"]!
            self.question.text = "Is this a good caption for this image? \n " + question
            self.image.image = UIImage(named:image_name)
        default:
            let id = Int.random(in: 0..<self.chart_examples.count)
            self.question.text = "Can you explain this chart to a friend?"
            self.image.image = UIImage(named:self.chart_examples[id])
        }
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
