import UIKit
import Alamofire
import Moya

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
    private var url_seoul: String = "https://api.openweathermap.org/data/2.5/weather?q=seoul&appid=1290787ef5eb584060b11b43e201a9fc"
    
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
            //self.getCurrentWeahterByAlamofire(cityName: cityName)
            self.getCurrentWeatherByMoya(cityName: cityName)
            
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
    func getCurrentWeatherByURLSession(cityName: String) {
        // 날씨 데이서 API url 연결
        guard let url = URL(string: url_seoul) else { return }
        
        // 1. Session Configuration 설정 + 생성
        let session = URLSession(configuration: .default)
        
        // 2. 사용할 Task 결정하고 메소드 작성
        session.dataTask(with: url) { [weak self]
            // Completion Handler
            // data : 서버에서 응답 받은 데이터
            // response : http 헤더 및 상태 코드 메타 데이터
            // error : 요청 실패 에러 객체. 성공하면 nil.
            data, response, error in
            // http status 가 200번대면 성공
            let successRange = (200..<300)
            guard let data = data, error == nil else { return }
            
            let decoder = JSONDecoder()
            
            // response 를 HTTPURLResponse 형태로 다운 캐스팅
            if let response = response as? HTTPURLResponse, successRange.contains(response.statusCode) {
                guard let weatherInformation = try? decoder.decode(WeatherInformation.self, from: data) else { return }
                
                // UI 작업은 메인 쓰레드에서 작업
                DispatchQueue.main.async {
                    self?.weatherStackView.isHidden = false
                    self?.configureView(weatherInformation: weatherInformation)
                }
            }
            else {
                guard let errorMessage = try? decoder.decode(ErrorMessage.self, from: data) else { return }
                
                DispatchQueue.main.async {
                    self?.showAlert(message: errorMessage.message)
                }
            }
        }.resume()
        
    }

  
}

extension ViewController {

    func getCurrentWeahterByAlamofire(cityName: String) {
        guard let url = URL(string: url_seoul) else { return }
        
        AF.request(url, method: .get, parameters: [:])
            .responseData(completionHandler: { response in
                let decoder = JSONDecoder()
                switch response.result {
                case let .success(data):
                    do {
                        let weatherInformation = try decoder.decode(WeatherInformation.self, from: data)
                        
                        DispatchQueue.main.async {
                            self.weatherStackView.isHidden = false
                            self.configureView(weatherInformation: weatherInformation)
                        }
                    } catch {
                        debugPrint(error)
                    }
                case let .failure(error):
                    debugPrint(error)
                }
            })
    }
    
}


extension ViewController {
    
    func getCurrentWeatherByMoya(cityName: String) {
        let moyaProvider = MoyaProvider<WeatherAPI>()
        
        moyaProvider.request(.getWeather) { (result) in
            switch result {
            case let .success(response):
                guard let result = try? response.map(WeatherInformation.self) else { return }
                DispatchQueue.main.async {
                    self.weatherStackView.isHidden = false
                    self.configureView(weatherInformation: result)
                }
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
        
    }
}

