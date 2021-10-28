// 구조체
struct User{
    var nickname: String
    var age: Int
    
    func infromation(){
        print("\(nickname) \(age)")
    }
}

// 정의한 구조체를 사용하기 위해서는 인스턴스를 생성해야 한다.
// 인스턴스를 생성한다는 것은 구조체나 클래스를 실제로 사용하기 위해서
// 메모리에 생성하는 것을 말한다.

var user1 = User(nickname: "KSW", age: 26)

user1.nickname
user1.nickname = "BSJ"
user1.nickname

user1.infromation()


// 클래스
class Dog {
    var name: String = ""
    var age: Int = 0
    
    init(){
    }
    
    func information(){
        print("\(name) \(age)")
    }
}

var dog = Dog()
dog.name = "Cloud"
dog.age = 3
dog.name
dog.age
dog.information()
