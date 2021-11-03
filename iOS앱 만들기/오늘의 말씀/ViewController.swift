//
//  ViewController.swift
//  오늘의 명언
//
//  Created by 김상우 on 2021/11/01.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var quoteLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var myTitle: UILabel!
    @IBOutlet weak var refreshButton: UIButton!
    @IBOutlet weak var madeBy: UILabel!
    
    let quotes = [
        Quote(contents: "미련한 자라도 잠잠하면 지혜로운 자로 여기우고 입술을 닫히면 슬기로운 자로 여기우느니라", name: "잠언 17:28"),
        Quote(contents: "가난한 자를 무시하는 사람은 그를 지으신 하나님을 멸시하는 자이며 가난한 자를 불쌍히 여기는 자는 하나님을 존경하는 자이다.", name: "잠언 14:31"),
        Quote(contents: "비판을 받지 아니하려거든 비판하지 말라", name: "마태복음 7:1"),
        Quote(contents: "너는 초대를 받거든 오히려 맨 끝자리에 가서 앉아라. 그러면 너를 초대한 사람이 와서 '여보게 저 윗자리에 가서 앉게' 하고 말할 것이다.", name: "누가복음 14:10"),
        Quote(contents: "여호와는 나의 목자시니 내게 부족함이 없으리로다.", name: "시편 23:1"),
        Quote(contents: "무릇 자기를 높이는 자는 낮아지고 자기를 낮추는 자는 높아지리라.", name: "누가복음 14:11"),
        Quote(contents: "사람이 마음으로 자기의 길을 계획할지라도 그의 걸음을 인도하시는 이는 여호와시니라", name: "잠언 16:8"),
        Quote(contents: "죽고 사는 것이 혀의 권세에 달렸나니 혀를 쓰기를 좋아하는 자는 그 열매를 먹으리라", name: "잠언 18:21"),
        Quote(contents: "말이 많으면 허물을 면키 어려우나 그 입술을 제어하는 자는 지혜가 있느니라" , name: "잠언 10:19"),
        Quote(contents: "모든 지킬만한 것보다 네 마음을 지키라 생명의 근원이 이에서 남이니라", name: "잠언 4:23")
        
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 폰트 목록에 Gowun Batang 이 없으면 제대로 들어가지 않은 것
        for family in UIFont.familyNames.sorted() {
            let names = UIFont.fontNames(forFamilyName: family)
            print("Family: \(family) Font names: \(names)")
        }
        
        
        // guard 문으로 폰트가 잘 추가 되었는지 에러 체크
        guard let gowun = UIFont(name: "Gowun Batang", size: 18) else {
            print("Gowun Batang is not in UIFont")
            return
        }
        
        myTitle.font = gowun
        quoteLabel.font = gowun
        nameLabel.font = gowun
        madeBy.font = gowun
        
        contentView.layer.cornerRadius = 20
        refreshButton.layer.cornerRadius = 10
        
        refreshButton.setTitle("리프레쉬", for: .normal)
        
    }


    
    // Touch Down 이벤트
    @IBAction func tapButtonTouchDown(_ sender: Any) {
        // 버튼 색상 변경
        self.refreshButton.backgroundColor = UIColor.darkGray
    }
    
    // Touch Up Inside 이벤트
    @IBAction func tapQuoteGeneratorButton(_ sender: Any) {
        let random = Int(arc4random_uniform(8))
        let quote = quotes[random]
        
        self.quoteLabel.text = quote.contents
        self.nameLabel.text = quote.name
        // 버튼 색상 변경
        self.refreshButton.backgroundColor = UIColor.lightGray
    }
    
}

