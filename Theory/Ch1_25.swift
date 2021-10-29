import Foundation

// 매개변수와 리턴타입이 없는 클로저 선언
let hello = { () -> () in
    print("hello")
}

// 클로저 호출
hello() // -> hello


// 매개변수와 리턴타입이 있는 클로저 선언
let hello2 = { (name: String) -> String in
    return "Hello \(name)"
}

// hello2(name: "KSW") -> 에러 ! 전달 인자 레이블 사용 금지
print(hello2("KSW"))    // -> Hello KSW


//// 클로저는 1급 객체이기 때문에 함수 파라미터로 사용할 수 있다.
//// 클로저를 함수 매개변수로 사용하기
//func doSomething(closure: () -> ()) {
//    closure()
//}
//
//doSomething(closure:{() -> () in
//    print("Do something!")})


// 클로저를 리턴하는 함수
func doSomething2() -> () -> () {
    return {
        () -> () in
        print("closure return")
    }
}

doSomething2()()    // -> closure return


// 후행 클로저
// 기본 클로저
func doSomething(closure: () -> ()) {
    closure()
}

doSomething(closure: { () -> () in
    print("hello")
})  // -> hello


// 매개변수와 반환값 모두 없었으므로 모두 생략 가능
doSomething() {
    print("hello2")
}   // -> hello2

// doSomething 처럼 매개변수가 단 하나의 매개변수인 경우,
// 소괄호도 생략 가능
doSomething {
    print("hello3")
}   // -> hello3


// 다중 후행 클로저
// 매개변수로 클로저를 2개 받는다.
func doSomething3(success: () -> (), fail: () -> ()){
    
}

// Xcode 자동완성 기능으로 Enter를 두 번치면,
// 자동으로 다중 후행 클로저를 완성시켜준다.
// 첫번째 클로저는 매개변수 레이블을 생략한다.
doSomething3 {
    <#code#>
} fail: {
    <#code#>
}


// 클로저 표현 간소화
// 클로저 매개변수를 받는 함수
func doSomething4(closure:(Int, Int, Int) -> Int){
    closure(1,2,3)
}

// 기본 클로저 형태
doSomething4 (closure: { (a: Int, b: Int, c: Int) in
    print(a+b+c)
    return a+b+c
})  // -> 6

// 경량 문법 : 파라미터와 리턴타입 생략 가능
// 약식 인수 이름 -> 매개변수 이름 대신에 사용
doSomething4 (closure : {
    print($0 + $1 + $2)
    return $0 + $1 + $2
})  // -> 6

// 단일 리턴문만 남았을 경우는 리턴 키워드도 생략 가능.
// 위에 print 같은 코드가 있으면 생략 불가능
doSomething4(closure: {
    $0 + $1 + $2
})  // -> 출력은 되지 않지만 6이라는 값 저장

// 위에서 공부한 후행 클로저
doSomething4 () {
    $0 + $1 + $2
}   // -> 매개변수 생략. 6이라는 값 저장.

// 단 하나의 클로저만 매개변수로 전달 되는 경우에는 소괄호도 생략 가능
// 맨 위의 기본 코드와 비교했을 때 길이가 매우 짧아졌음.
// (출력하는 기능은 중간에 빼긴 했음)
doSomething4 {
    $0 + $1 + $2
}
