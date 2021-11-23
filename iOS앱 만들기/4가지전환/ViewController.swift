//
//  ViewController.swift
//  ScreenTransactionExample
//
//  Created by 김상우 on 2021/11/19.
//

import UIKit

class ViewController: UIViewController, SendDataDelegate {

    @IBOutlet weak var nameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func tapCodePushButton(_ sender: UIButton) {
        // 가고 싶은 뷰 컨트롤러를 인스턴스화
        guard let viewController = self.storyboard?.instantiateViewController(withIdentifier: "CodePushViewController") as? CodePushViewController else {return}
        viewController.name = "Kim Sang Woo 1"
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    
    @IBAction func tapCodePresentButton(_ sender: UIButton) {
        // 가고 싶은 뷰 컨트롤러를 인스턴스화
        guard let viewController = self.storyboard?.instantiateViewController(withIdentifier: "CodePresentViewController") as? CodePresentViewController else {return}
        viewController.name = "Kim Sang Woo 2"
        viewController.delegate = self
        // 풀 스크린으로 띄우고 싶다면
        // viewController.modalPresentationStyle = .fullScreen
        self.present(viewController, animated: true, completion: nil)
    }
    
    // prepare 메서드를 오버라이드 하면 Segueway 화면 전환 실행 직전에 자동 호출됨
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? SegPushViewController {
            viewController.name = "Kim Sang Woo 4"
        }
    }
    
    func sendData(name: String) {
        self.nameLabel.text = name
        self.nameLabel.sizeToFit()
    }
}

