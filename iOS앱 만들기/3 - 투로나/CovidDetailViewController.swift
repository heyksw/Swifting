//
//  CoivdDetailViewController.swift
//  Torona
//
//  Created by 김상우 on 2021/11/18.
//

import UIKit

class CoivdDetailViewController: UITableViewController {

    @IBOutlet weak var newCaseCell: UITableViewCell!
    @IBOutlet weak var totalCaseCell: UITableViewCell!
    @IBOutlet weak var recoveredCell: UITableViewCell!
    @IBOutlet weak var deathCell: UITableViewCell!
    @IBOutlet weak var percentageCell: UITableViewCell!
    @IBOutlet weak var overseasInflowCell: UITableViewCell!
    @IBOutlet weak var regionalOutbreakCell: UITableViewCell!
    
    // 이 프로퍼티로 선택된 지역의 발생 현황 데이터를 전달 받음
    var covidOverview: CovidOverview?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureView()
    }
    
    func configureView() {
        // 옵셔널 바인딩
        guard let covidOverview = self.covidOverview else { return }
        // 네비게이션 바 타이틀 세팅
        self.title = covidOverview.countryName
        self.newCaseCell.detailTextLabel?.text = "\(covidOverview.newCase) 명"
        self.totalCaseCell.detailTextLabel?.text = "\(covidOverview.totalCase) 명"
        self.recoveredCell.detailTextLabel?.text = "\(covidOverview.recovered) 명"
        self.deathCell.detailTextLabel?.text = "\(covidOverview.death) 명"
        self.percentageCell.detailTextLabel?.text = "\(covidOverview.percentage) %"
        self.overseasInflowCell.detailTextLabel?.text = "\(covidOverview.newFcase) 명"
        self.regionalOutbreakCell.detailTextLabel?.text = "\(covidOverview.newCcase) 명"
    }

}
