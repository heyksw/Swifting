class KSW {
    // static
    static func introduce() {
        print("Hi I'm Kim Sang Woo")
    }
    // class
    class func sayBye() {
        print("Bye")
    }
}

class KSW2: KSW {
    static var age = 25
    // 오버라이딩 금지
    // override static func introduce() {}
    
    // 오버라이딩 허용
    override class func sayBye() {
        print("Bye Bye")
    }
}

KSW2.sayBye()

// 타입 메서드와 인스턴스 메서드의 접근 범위
class KSW3 {
    let name = "Kim Sang Woo"
    static let age = 26
    
    // 인스턴스 메서드
    func introduce() {
        // 저장 프로퍼티 접근 가능
        print("이름은 \(name)")
        
        // 타입 프로퍼티의 타입을 안다면 접근 가능
        print("나이는 \(KSW3.age)")
    }
    
    // 타입 메서드
    class func introduce2() {
        // 저장 프로퍼티 접근 불가능
        // print("이름은 \(name)")
        
        // 같은 타입 멤버는 타입이름 없이 접근 가능
        print("나이는 \(age)")
        print("다른 타입 접근 : \(KSW2.age)")
    }
}


KSW3.introduce2()



