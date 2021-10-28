// Init과 Property

// Init() 활용하기. self 키워드 활용
class User {
    var nickname: String
    var age: Int
    
    init(nickname: String, age: Int){
        self.nickname = nickname
        self.age = age
    }
    
    // 생성자 오버로딩
    init(age: Int){
        self.nickname = "BSJ"
        self.age = age
    }
    
    // 소멸자. 클래스에서만 선언 가능
    deinit {
        print("deinit User")
    }
    
}

var user = User(nickname: "KSW", age: 26)
user.nickname
user.age

var user2 = User(age: 27)
user2.nickname
user2.age

var user3: User? = User(age: 29)
// nil을 대입시키면 인스턴스가 더 이상 필요하지 않다고 판단.
// 소멸자 호출
user3 = nil


// 저장 프로퍼티
struct Cat {
    var name: String
    let gender: String
}

var cat = Cat(name: "Cloud", gender: "male")
print(cat)
cat.name = "Binu"
cat.name

// 구조체와 클래스의 차이점
let cat2 = Cat(name: "Momo", gender: "male")
// cat2.name = "Cloud" -> let 상수로 선언 했기 때문에 오류 !

// 하지만 클래스는 let으로 선언해도 프로퍼티 값 변경이 가능하다.
class Rabbit{
    var name: String
    let gender: String
    
    init(name: String, gender: String){
        self.name = name
        self.gender = gender
    }
}
    
let rabbit = Rabbit(name: "Cookie", gender: "male")
rabbit.name = "Cloud"
rabbit.name

// 구조체는 value 타입이기 때문에, 상수로 선언하면 프로퍼티 변경이 되지 않음.
// 클래스는 참조 타입이기 때문에, 상수로 선언해도 프로퍼티 변경이 가능하다.

// 계산(연산) 프로퍼티
// 저장 프로퍼티는 구조체, 클래스에서만 사용이 가능했다.
// 계산 프로퍼티는 열거형까지 사용이 가능하다.
// 계산 프로퍼티는 getter와 setter를 사용한다.
// get만 구현하면 읽기 전용 프로퍼티가 된다.
// set의 매개변수 이름을 설정하지 않으면 default로 "newValue"라는 이름으로 사용 가능하다.
struct Stock {
    var averagePrice: Int
    var quantity: Int
    // 계산 프로퍼티
    var purchasePrice: Int {
        get {
            return averagePrice * quantity
        }
        set(newPrice) {
            averagePrice = newPrice / quantity
        }
    }
}

var stock = Stock(averagePrice: 2300, quantity: 3)
print(stock)
stock.purchasePrice
stock.purchasePrice = 3000
stock.purchasePrice
stock.averagePrice

// 프로퍼티 옵저버
// 프로퍼티 값 변화를 관찰하고 반영한다.
// 새로운 값이 기존값과 같더라도 호출된다.
// 프로퍼티 값이 set 될 때마다 호출된다고 생각하면 된다.

// 3가지 경우에 사용가능
// 저장 프로퍼티, 오버라이딩 된 저장, 계산 프로퍼티

// willSet : 값이 저장되기 직전
// didSet : 값이 저장된 직후

class Account {
    var credit: Int = 0{
        willSet {
            print("잔액이 \(credit)원에서 \(newValue)원으로 변경될 것입니다.")
        }
        didSet {
            print("잔액이 \(oldValue)원에서 \(credit)원으로 변경 되었습니다.")
        }
    }
}

var account = Account()
account.credit = 1000

// 타입 프로퍼티
// 인스턴스의 생성 없이 객체 내의 프로퍼티에 접근 가능하게 하는 것
// 프로퍼티의 타입 자체와 연결하는 것
// 타입 프로퍼티는 저장 프로퍼티와 연산 프로퍼티에서만 사용 가능하다.
// static 키워드를 사용하다.
struct SomeStructure {
    static var storedTypeProperty = "Some value"
    
    static var computedTypeProperty: Int {
        return 100
    }
}

SomeStructure.storedTypeProperty = "Hello"
SomeStructure.computedTypeProperty
SomeStructure.storedTypeProperty
