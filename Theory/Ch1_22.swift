// 열거형
enum CompassPoint: String {
    // 원시값 할당
    case north = "북"
    case south = "남"
    case east = "동"
    case west = "서"
    
    // 열거형 안에 인스턴스 메서드도 포함할 수 있다.
    func printDirection() {
        // 원시값 출력
        print(self.rawValue)
    }
}

var direction = CompassPoint.north  // north
// direction이 CompassPoint형 이라는 것을 유추하기 때문에 .만 붙여도 됨
direction = .west   // west
direction.printDirection()  // "서"

// 원시값으로 초기화하기
var direction2 = CompassPoint(rawValue: "동")
direction2?.printDirection()    // "동"


// 연관값 가지기. 소괄호로 가질 수 있음.
enum PhoneError {
    case unknown
    // String형 연관값
    case batteryLow(String)
}

let error = PhoneError.batteryLow("배터리 부족!")

switch error {
case .batteryLow(let message):
    print(message)
case .unknown:
    print("알 수 없는 에러")
}

// "배터리 부족!"
