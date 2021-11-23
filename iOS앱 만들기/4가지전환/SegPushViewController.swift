//
//  SegPushViewController.swift
//  ScreenTransactionExample
//
//  Created by 김상우 on 2021/11/19.
//

import UIKit

class SegPushViewController: UIViewController {
    
    @IBOutlet weak var tapBackButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    
    var name: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let name = name {
            self.nameLabel.text = name
            self.nameLabel.sizeToFit()
        }
    }
    
    @IBAction func tapBackButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
