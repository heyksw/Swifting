//
//  ViewController.swift
//  Torona
//
//  Created by 김상우 on 2021/11/18.
//

import UIKit
import Charts
import Alamofire

class ViewController: UIViewController {

    @IBOutlet weak var totalCaseLabel: UILabel!
    @IBOutlet weak var newCaseLabel: UILabel!
    @IBOutlet weak var pieChartView: PieChartView!
    @IBOutlet weak var labelStackView: UIStackView!
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    @IBOutlet weak var refreshButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 로딩중 애니메이션
        self.indicatorView.startAnimating()
        self.fetchCovidOverview(myClosure: { [weak self] result in
            // 일시적으로 self 가 strong reference 가 되게 만들어줌
            guard let self = self else {return}
            switch result {
            case let .success(data):
                // 서버 응답이 성공하면 로딩중 애니메이션을 멈춤
                self.indicatorView.stopAnimating()
                self.indicatorView.isHidden = true
                
                // hidden 뷰들을 보여줌
                self.labelStackView.isHidden = false
                self.pieChartView.isHidden = false
                
                // Alamofire 에서는 response data 의 Completion Handler 는 메인쓰레드에서 동작함
                // 그래서 UI 작업을 할 때 따로 메인 Dispatch Queue를 안 만들어도 됨
                self.configureStackView(koreaCovidOverview: data.korea)
                let covidOverviewList = self.makeCovidOverviewList(cityCovidOverview: data)
                self.configureChartView(covidOverviewList: covidOverviewList)
                
            case let .failure(error):
                debugPrint("error \(error)")
            }
        })
    }
    
    
    // stack 뷰에 국내 확진자, 국내 신규 확진자 수를 표시하는 함수
    func configureStackView(koreaCovidOverview: CovidOverview) {
        self.totalCaseLabel.text = "\(koreaCovidOverview.totalCase) 명"
        self.newCaseLabel.text = "\(koreaCovidOverview.newCase) 명"
    }
    
    
    // 배열에 시도별 정보를 담음
    func makeCovidOverviewList(
        cityCovidOverview: CityCovidOverview
    ) -> [CovidOverview] // 배열 형식으로 리턴
    {
        return [
            cityCovidOverview.seoul,
            cityCovidOverview.busan,
            cityCovidOverview.daegu,
            cityCovidOverview.incheon,
            cityCovidOverview.gwangju,
            cityCovidOverview.daejeon,
            cityCovidOverview.ulsan,
            cityCovidOverview.sejong,
            cityCovidOverview.gyeonggi,
            cityCovidOverview.chungbuk,
            cityCovidOverview.chungnam,
            cityCovidOverview.gyeongbuk,
            cityCovidOverview.gyeongnam,
            cityCovidOverview.jeju
        ]
    }
    
    
    // 파이차트에 데이터 표시하는 함수
    // 파이차트에 데이터를 표시하려면 Pie Chart Data Entry 라는 객체에 데이터를 추가해줘야 함
    func configureChartView(covidOverviewList: [CovidOverview]) {
        // pieChart 에서 항목을 선택했을 때 covidOverview 를 넘겨주기 위함
        // 이 delegate 를 받음으로써 밑에 ChartViewDelegate 프로토콜 준수 코드를 작성해줌.
        self.pieChartView.delegate = self
        
        // compatMap 을 이용한 CovidOverview -> PieChartDataEntry 데이터 매핑
        let entries = covidOverviewList.compactMap { [weak self] overview -> PieChartDataEntry? in
            // 일시적으로 self 가 강한 참조를 갖도록 함
            guard let self = self else {return nil}
            
            // 파이차트 데이터 엔트리로 매핑. 그런데 overview.newCase 를 그냥 넣어주면 에러가 남.
            // value 에는 double 타입이 와야하는데, json 데이터가 콤마를 포함한 string 타입으로 오기 때문.
            return PieChartDataEntry(
                value: self.removeFormatString(string: overview.newCase),
                label: overview.countryName,
                data: overview
            )
        }
        
        let dataSet = PieChartDataSet(entries: entries, label: "코로나 발생 현황")
        
        dataSet.sliceSpace = 1  // 간격 1로 설정
        dataSet.entryLabelColor = .black    // 라벨 컬러 검정으로 설정
        dataSet.valueTextColor = .black     // 항목 밸류 값 검정
        dataSet.xValuePosition = .outsideSlice  // 항목 이름이 파이 차트 바깥에 표시되도록 설정
        dataSet.valueLinePart1OffsetPercentage = 0.8
        dataSet.valueLinePart1Length = 0.2
        dataSet.valueLinePart2Length = 0.3  // 바깥쪽 선으로 표시된 항목의 이름이 가독성이 좋아지도록.
        
        dataSet.colors = ChartColorTemplates.vordiplom() +
        ChartColorTemplates.joyful() + ChartColorTemplates.liberty() +
        ChartColorTemplates.pastel() + ChartColorTemplates.material()
        
        self.pieChartView.data = PieChartData(dataSet: dataSet)
        self.pieChartView.spin(duration: 0.3, fromAngle: self.pieChartView.rotationAngle, toAngle: self.pieChartView.rotationAngle + 80)
        // 파이 차트 구현함수 완료.
        // 이 함수를 Completion Handler success 문 안에 넣어주면 됨.
    }
    
    
    // string 데이터를 double 로 변환하는 함수
    func removeFormatString(string: String) -> Double {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter.number(from: string)?.doubleValue ?? 0
    }


    // 서버에서 코로나 관련 json 데이터를 불러오는 함수
    func fetchCovidOverview (
        // API 요청하고 json 데이터를 응답받거나 실패했을 때,
        // 이 클로저로 해당 클로저를 정의한 곳에 응답받은 데이터를 전달하려 함
        // 탈출 클로저로 선언함으로써 responseData 의 completionHandler 가 호출되기 전에,
        // 함수가 반환돼버려서 오류가 생기는 경우를 방지.
        myClosure: @escaping (Result<CityCovidOverview, Error>) -> Void
    ) {
        let url = "https://api.corona-19.kr/korea/country/new/"
        let param = [
            "serviceKey" : "8UQF357Imbgx2BEzTnkNvs69tdAjePrYR"
        ]
        // 해당 API 호출
        // param 에 딕셔너리 형태로 넣으면 알아서 url 뒤에 쿼리 파라미터를 추가한다.
        // 그래서 뒤에 필요한 매개변수를 생략해도 된다.
        AF.request(url, method: .get, parameters: param)
        // request 메서드를 이용해 요청을 했으면 응답 데이터를 받을 수 있는 메서드를 체이닝 해야한다.
        // 응답 데이터가 클로저 파라미터로 전달된다.
            .responseData(completionHandler: { response in
                // 응답 받은 데이터는 response.result 에 열거형으로 저장된다.
                switch response.result {
                // 만약 요청 결과가 success 이면 연관값으로 서버에서 받은 data 가 전달된다.
                case let .success(data):
                    // 응답 받은 json 데이터를 CityCovidOverview 구조체에 매핑되는 코드 작성
                    do {
                        let decoder = JSONDecoder()
                        let result = try decoder.decode(CityCovidOverview.self, from: data)
                        myClosure(.success(result))
                    } catch {
                        // json 매핑이 실패 했을 경우
                        myClosure(.failure(error))
                    }
                // 요청 결과가 failure 인 경우
                case let .failure(error):
                    myClosure(.failure(error))
                }
                
            })
    }
    
    
    // 출처: https://royhelen.tistory.com/46 [꾸르꾸르]
    func showToast(message : String, font: UIFont) {
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height-100, width: 150, height: 35))
        
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.font = font
        toastLabel.textAlignment = .center;
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 5;
        toastLabel.clipsToBounds = true
        toastLabel.sizeToFit()
        
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0 }, completion: {(isCompleted) in toastLabel.removeFromSuperview() }) }

    
    // 새로 추가한 기능. 새로고침과 새로고침 되었음을 날짜와 함께 표시
    @IBAction func tapRefreshButton(_ sender: UIButton) {
        // 새로고침 할 때 파이차트를 감춤
        self.labelStackView.isHidden = true
        self.pieChartView.isHidden = true
        
        // 다시 indicator 를 보여줌
        self.indicatorView.isHidden = false
        self.indicatorView.startAnimating()
        
        // 서버에서 다시 데이터를 가져옴
        self.fetchCovidOverview(myClosure: { [weak self] result in
            // 일시적으로 self 가 strong reference 가 되게 만들어줌
            guard let self = self else {return}
            switch result {
            case let .success(data):
                // 서버 응답이 성공하면 로딩중 애니메이션을 멈춤
                self.indicatorView.stopAnimating()
                self.indicatorView.isHidden = true
                
                // hidden 뷰들을 보여줌
                self.labelStackView.isHidden = false
                self.pieChartView.isHidden = false
                
                // Alamofire 에서는 response data 의 Completion Handler 는 메인쓰레드에서 동작함
                // 그래서 UI 작업을 할 때 따로 메인 Dispatch Queue를 안 만들어도 됨
                self.configureStackView(koreaCovidOverview: data.korea)
                let covidOverviewList = self.makeCovidOverviewList(cityCovidOverview: data)
                self.configureChartView(covidOverviewList: covidOverviewList)
                
            case let .failure(error):
                debugPrint("error \(error)")
            }
        })
        
        let formatter = DateFormatter()
        formatter.dateFormat = "hh시 mm분 ss초 갱신 완료."
        let msg = formatter.string(from: Date())
        let font = UIFont.systemFont(ofSize: 14.0)
        
        self.showToast(message: msg, font: font)
        
    }
    
}



extension ViewController: ChartViewDelegate {
    // 차트에서 항목을 선택했을 때 실행되는 메서드
    // ChartViewDelegate 프로토콜의 메서드임.
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        // 다운 캐스팅
        guard let covidDetailViewController = self.storyboard?.instantiateViewController(withIdentifier: "CoivdDetailViewController") as? CoivdDetailViewController else {return}
        
        guard let covidOverview = entry.data as? CovidOverview else {return}
        // CovidDetailViewController.swift 의 프로퍼티에 데이터 전달
        covidDetailViewController.covidOverview = covidOverview
        // Navigation stack push
        self.navigationController?.pushViewController(covidDetailViewController, animated: true)
    }

    
}

