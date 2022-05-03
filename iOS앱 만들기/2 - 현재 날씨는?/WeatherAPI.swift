import Foundation
import Moya

enum WeatherAPI {
    case getWeather
    // case setWeather
}

// TargetType : MoyaProvider에 필요한 규격을 정의하는데 사용되는 프로토콜
extension WeatherAPI: TargetType {
    // 서버의 base URL, end point 도메인
    var baseURL: URL {
        return URL(string: "https://api.openweathermap.org/data/2.5/weather?q=seoul&appid=1290787ef5eb584060b11b43e201a9fc")!
    }
    
    // 도메인 뒤에 추가 될 path (/users, /documents, ...)
    var path: String {
        switch self {
        case .getWeather:
            return ""
        }
    }
    
    // HTTP 메소드 (GET, POST, ...)
    var method: Moya.Method {
        switch self {
        case .getWeather:
            return .get
        }
    }
    
    // 테스트용 Mock Data
    var sampleData: Data {
        return Data()
    }
    
    // request에 사용될 파라미터
    // .requestPlain : 파라미터 없을 때
    // .requestParameters(parameter: ,encoding: )
    var task: Task {
        switch self {
        case .getWeather:
            return .requestPlain
        }
    }
    
    // HTTP header 에 대한 배경지식 필요
    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
}
