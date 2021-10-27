protocol someProtocol {
    init(value: Int)
}

class someClass: someProtocol {
    required init(value: Int) {
        print(value)
    }

}

struct someStruct: someProtocol {
    init(value: Int) {
        print(value)
    }
}


let class1 = someClass(value: 100)
let struct1 = someStruct(value: 200)

protocol someProtocol2 {
    init(value: Int)
}

struct someStruct2: someProtocol2 {
    init(value: Int) {}
}

let struct2 = someStruct2(value: 1)

var someAny: Any = class1
someAny is someProtocol     // true
someAny is someProtocol2    // false

var someAny2: Any = struct2

if let result = someAny2 as? someProtocol {
    print("프로토콜 타입이 다릅니다.")
}
else{
    print("프로토콜을 준수합니다.")
}
