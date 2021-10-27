// 덧셈 함수 선언
func sum(a: Int, b: Int) -> Int {
    return a+b
}

sum(a:5, b:3)

func hello() -> String {
    return "Hello"
}

hello()

func printName() -> Void {
    print("My name is Kim Sang Woo")
}

printName()

func greeting(friend: String, me: String = "KSW") {
    print("Hello \(friend), I'm \(me)")
}

greeting(friend: "BSJ")

func sayHello(name: String) -> Void{
  print("Hello, I'm \(name)")
}

sayHello(name: "KSW")

// 전달 인자 레이블
// 이렇게 함수를 호출할 때 전달인자 레이블을 사용하면
// 사용자 입장에서 매개변수의 역할을 좀 더 명확하게 표현할 수 있어서
// 코드의 가독성이 높아진다.
func sendMessage(from myName: String, to name: String)
-> String{
    return "Hello \(name)! I'm \(myName)"
}

sendMessage(from: "KSW", to: "BSJ")

// 와일드 카드 식별자
// 매개변수 앞에 언더 바를 적어주면 전달인자 레이블을 사용하지 않음
// 호출할 때 매개변수 이름을 적지 않고 값만 적어줘도 됨.
func _sendMessage(_ name: String) ->String{
    return "Hello, I'm \(name)"
}

_sendMessage("KSW")

// 가변 매개변수 - 0개 이상의 값을 받아옴
// 함수마다 가변 매개변수는 하나만 가질 수 있다.

func sendMessage(me: String, friends: String...) -> String {
    return "Hello \(friends)!, I'm \(me)"
}

sendMessage(me: "KSW", friends:"BSJ", "BSY", "BSG")

// * Swift는 함수형 프로그래밍 패러다임을 포함하는 다중 프로그래밍 패러다임 언어.
// 함수는 1급 객체이다.
// 함수를 변수, 상수 등에 할당할 수도 있다.
// 매개변수로 전달할 수 도있다.
