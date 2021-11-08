import Foundation

// Codable 프로토콜을 채택함으로써 json 형태 인코딩, 디코딩 가능
struct WeatherInformation: Codable {
    let weather: [Weather]
    let temp: Temp
    let name: String
    let sys: Sys
    
    enum CodingKeys: String, CodingKey {
        case weather
        case temp = "main"
        case name
        case sys
    }
    
}

// json 데이터 중 weather 에서 필요한 key, property
// json key 이름과 swift 변수 이름을 똑같이 지정
struct Weather: Codable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

// json 데이터 중 main 에서 필요한 key, property
// json key 이름과 swift 변수 이름을 다르게 지정 했지만 매핑 시킴
struct Temp: Codable {  
    let temp: Double
    let feelsLike: Double
    let minTemp: Double
    let maxTemp: Double
    // pressure와 humidity는 사용하지 않음.
    
    // CodingKey 프로토콜 준수 -> 매핑
    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case minTemp = "temp_min"
        case maxTemp = "temp_max"
    }
    
}

struct Sys: Codable {
    let country: String
}
