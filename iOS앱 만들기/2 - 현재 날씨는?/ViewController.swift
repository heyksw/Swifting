import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var bigView: UIView!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var cityNameTextField: UITextField!
    @IBOutlet weak var tapButton: UIButton!
    @IBOutlet weak var weatherDescriptionLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    @IBOutlet weak var minTempLabel: UILabel! 
    @IBOutlet weak var weatherStackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bigView.layer.cornerRadius = 20
        self.cityNameTextField.layer.cornerRadius = 20
        self.tapButton.layer.cornerRadius = 10
        // Do any additional setup after loading the view.
    }

    @IBAction func tapTouchDown(_ sender: Any) {
        self.tapButton.backgroundColor = UIColor.lightGray
    }
    
    // 날씨 가져오기 버튼을 눌렀을 때
    @IBAction func tapFetchWeatherButton(_ sender: UIButton) {
        self.tapButton.backgroundColor = UIColor(displayP3Red: 227/255, green: 227/255, blue: 227/255, alpha: 1)
        
        if let cityName = self.cityNameTextField.text {
            self.getCurrentWether(cityName: cityName)
            self.view.endEditing(true)
            // 버튼이 눌리면 키보드가 사라지도록 함.
        }
    }
    
    // 받아온 json 데이터를 뷰에 표시
    func configureView(weatherInformation: WeatherInformation) {
        self.cityNameLabel.text = weatherInformation.name
        // json 형식에서 weather가 배열 형태 [] 였기 때문에 first 로 첫번째 값을 받아옴.
        if let weather = weatherInformation.weather.first {
            self.weatherDescriptionLabel.text = weather.description
        }
        self.temperatureLabel.text = "\(Int(weatherInformation.temp.temp - 273.15))℃ "
        self.minTempLabel.text = "최저 : \(Int(weatherInformation.temp.minTemp - 273.15))℃  "
        self.maxTempLabel.text = "최고 : \(Int(weatherInformation.temp.maxTemp - 273.15))℃  "
        self.countryLabel.text = "\(weatherInformation.sys.country)"
        
    }
    
    // 잘못된 도시 이름이 입력될 경우, alert 생성
    func showAlert(message: String) {
        let alert = UIAlertController(title: "에러", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    // API에서 현재 날씨 가져오기
    func getCurrentWether(cityName: String) {
        // api url 연결
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(cityName)&appid=1290787ef5eb584060b11b43e201a9fc") else
        { print("url error")
          return }
        
        let session = URLSession(configuration: .default)
        // weak self
        session.dataTask(with: url) { [weak self]
            // Completion Handler 후행 클로저
            // data : 서버에서 응답 받은 json 데이터
            // response : http 헤더 및 상태 코드 메타 데이터
            // error : 요청 실패 에러 객체. 성공하면 nil.
            data, response, error in
            // http status가 200번대 이면 응답받은 json 데이터를 weatherInformation 객체로 디코딩
            // 200번대 가 아니라면 에러 상황. 응답받은 json 데이터를 에러 메시지 객체로 디코딩 함.
            let successRange = (200..<300)
            // 데이터를 잘 받아오고, 에러가 없다면 다음 코드 수행
            guard let data = data, error == nil else {
                print("session error")
                return }
            
            // json 객체에서 data 유형의 인스턴스로 디코딩
            let decoder = JSONDecoder()
            
            // response를 HTTP URLResponse 형태로 다운 캐스팅 하고,
            // successRange에 status code를 넘겨줘서 200번대 인지 확인
            if let response = response as? HTTPURLResponse, successRange.contains(response.statusCode) {
                // status code가 200번대 인 경우 (json 데이터를 성공적으로 받아왔을 경우)
                
                // json 을 매핑 시켜줄 사용자 정의 타입
                guard let weatherInformation = try? decoder.decode(WeatherInformation.self, from: data) else { return }
                // 콘솔에 데이터를 잘 받았는지 출력
                debugPrint(weatherInformation)
                
                // UI 작업은 메인쓰레드에서 작업
                DispatchQueue.main.async {
                    // 날씨 데이터를 가져왔으면, hidden 이 풀리면서 정보를 보여주도록.
                    self?.weatherStackView.isHidden = false
                    // configureView 함수를 통해 json 데이터를 뷰에 표시.
                    self?.configureView(weatherInformation: weatherInformation)
                }
            } else { // status code가 200번대 가 아닌경우 에러
                guard let errorMessage = try? decoder.decode(ErrorMessage.self, from: data) else {return}
                
                // 에러 메시지를 띄우는 Alert UI 작업은 메인쓰레드에서 작업
                DispatchQueue.main.async {
                    self?.showAlert(message: errorMessage.message)
                }
                
            }
            
            
            
        }.resume()  // resume 까지 해줘야 작업 실행
    }

  
}

