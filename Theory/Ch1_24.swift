// swift 예외처리

enum PhoneError: Error {
    case unknown
    case batteryLow(batteryLevel: Int)
}

// throw PhoneError.batteryLow(batteryLevel: 20)


// throwing 함수
// 함수에 throws 키워드를 사용한다.
func checkPhoneBatteryStatus(batteryLevel: Int) throws -> String {
    // batteryLevel 이 -1 이라면
    guard batteryLevel != -1 else {
        throw PhoneError.unknown
    }
    
    // batteryLevel 이 20 이하라면
    guard batteryLevel > 20 else{
        throw PhoneError.batteryLow(batteryLevel: batteryLevel)
    }
    
    return "배터리가 충분합니다."
}

//checkPhoneBatteryStatus(batteryLevel: 30)
//checkPhoneBatteryStatus(batteryLevel: 10)


// do catch 문으로 오류 처리
do {
    try checkPhoneBatteryStatus(batteryLevel: 10)
} catch PhoneError.unknown {
    print("unknown error !")
} catch PhoneError.batteryLow(let level) {
    print("low battery ! current battery : \(level)%")
} catch {   // error 라는 지역상수가 자동으로 생성됨
    print("예상 밖의 오류 : \(error)")
} // low battery ! current battery : 10%


// try? 문
// 에러를 옵셔널 값으로 변환하여 표현
// 동작하던 코드가 오류를 던지면, 그 코드의 반환값은 nil이 됨
let status = try? checkPhoneBatteryStatus(batteryLevel: -1)
print(status)   // -> nil

let status2 = try? checkPhoneBatteryStatus(batteryLevel: 40)
print(status2)  // -> Optional("배터리가 충분합니다.")

// try! 문
// 에러가 나지 않는다고 절대적으로 확신할 때만 사용
// 옵셔널 껍질이 벗겨짐
let status3 = try! checkPhoneBatteryStatus(batteryLevel: 30)
print(status3)  // -> 배터리가 충분합니다.
// 만약 에러가 발생한다면 프로그램 강제 종료.
