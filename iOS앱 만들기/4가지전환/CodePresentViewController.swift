//
//  CodePresentViewController.swift
//  ScreenTransactionExample
//
//  Created by 김상우 on 2021/11/20.
//

import UIKit

// AnyObject 나 class 를 상속 받는다면,
// 이 프로토콜은 오직 클래스에서만 사용이 가능하다는 뜻
protocol SendDataDelegate: AnyObject {
    func sendData(name: String)
}

class CodePresentViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    var name: String?
    
    // 타입이 프로토콜인 property 를 생성해줘야 하고 weak 을 붙여줘야 함
    // weak 을 붙여주는 것은 ViewController <-> CodePresentViewController
    // 붙이지 않는다면 서로를 동시에 참조하게되서 메모리가 영원히 해제되지 않음. 메모리 누수
    // ARC 와 관련된 개념.
    // 무작정 weak 을 쓸 수 있는게 아니라 클래스만 사용가능한 프로토콜에서 사용가능.
    weak var delegate: SendDataDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let name = name else {return}
        self.nameLabel.text = name
        self.nameLabel.sizeToFit()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func tapBackButton(_ sender: UIButton) {
        // delegate 에서 사용할 기능 전달
        self.delegate?.sendData(name: "Kim Sang Woo 3")
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
}
