## [현재 날씨는?] 앱 실행화면 gif

<img src = "https://user-images.githubusercontent.com/61315014/140777737-cc660ffe-ea77-44f1-8a00-22378e5274cf.gif" width = "20%">

- URLSession으로 서버와 소통하여, 전세계 도시의 날씨 정보를 출력하는 앱.   
- 블로그 링크 : https://velog.io/@heyksw/아이폰-앱-2-현재-날씨는

## 개발 정보
<pre>
- 프로그래밍 언어 : swift
- 개발 환경 : XCode, StoryBoard

- 활용 기술 

1. URLSession / URLSession Task
2. CurrentWeatherAPI / Json Parsing
3. Moya   
4. Alamofire

</pre>

## 비판적 클론코딩

### 국가 이름 데이터 추가

<block>

도시 이름 (ex: Seoul, Tokyo, London) 을 기반으로 한 날씨 데이터를 가져오지만, 그 도시가 어느 나라에 속해있는지도 표시하고 싶었습니다.
Codable 프로토콜을 준수하며 json parsing 이 가능하게 하고, sys json key 에 속한 country 데이터를 가져왔습니다.

```swift
// json decoder 에 들어갈 사용자 정의 타입 구조체
struct WeatherInformation: Codable {
    let weather: [Weather]
    let temp: Temp
    let name: String
    // sys 안의 "country" key 값에 국가 데이터가 들어있음.
    let sys: Sys
    
    enum CodingKeys: String, CodingKey {
        case weather
        case temp = "main"
        case name
        case sys
    } 
}

// 어떤 나라인지에 대한 데이터.
struct Sys: Codable {
    let country: String
}
```

</block>
   
### 5/4 리팩토링
   
<block>   

- Moya, Alamofire 방식으로 각각 getCurrentWeather 함수 작성   
getCurrentWeahterByAlamofire   
getCurrentWeahterByAlamofire   
    
</block>
