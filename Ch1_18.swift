// 상속
class Vehicle {
    // final 키워드를 사용하면 오버라이딩을 막는다.
    // final var currentSpeed = 0
    
    var currentSpeed = 0
    var description: String {
        return "traveling at \(currentSpeed) miles per hour"
    }
    func makeNoise() {
        print("Super class : speaker on")
    }
}

// : 키워드로 상속받는다.
class Bicycle : Vehicle {
    var hasBasket = false
}

// 자식 클래스에 선언되지 않았지만,
// 부모 클래스에 선언된 프로퍼티를 접근할 수 있다.
var bicycle = Bicycle()
bicycle.currentSpeed = 15
bicycle.currentSpeed

class Train : Vehicle {
    // 부모 클래스의 메서드를 오버라이드 한다.
    override func makeNoise() {
        // super 키워드를 통해 super 클래스에 정의된 메서드를 호출한다.
        super.makeNoise()
        print("Train class : choo choo")
    }
}

let train = Train()
train.makeNoise()

class Car : Vehicle {
    var gear = 1
    // 프로퍼티 오버라이딩
    override var description: String {
        // super 클래스의 description 을 호출하고, 거기에 덧붙인다.
        return super.description + " in gear \(gear)"
    }
}

let car = Car()
car.currentSpeed = 30
car.gear = 2
print(car.description)

class AutomaticCar : Car {
    // 프로퍼티 오버라이딩
    override var currentSpeed: Int {
        // 프로퍼티 옵저버
        didSet {
            gear = Int(currentSpeed/10)+1
        }
    }
}

let automatic = AutomaticCar()
automatic.currentSpeed = 35
print("AutomaticCar : \(automatic.description)")
