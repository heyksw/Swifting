// 명시적 해제
// 강제 해제 (느낌표 붙이기. 위험함)
var number: Int? = 3
print(number)
print(number!)
// 비강제 해제 1 (if문 사용 옵셔널 바인딩)
if let result = number {
    print(result)
} else{
    print("nil")
}


// 비강제 해제 2 (gaurd문 사용 옵셔널 바인딩)
// guard 문을 사용해서도 옵셔널 바인딩을 할 수 있다.
// 나중에 더 자세히 공부.


// 컴파일러에 의한 자동 해제
// 옵셔널 값은 비교연산자를 이용해 다른 값과 비교하면,
// 컴파일러가 자동적으로 옵셔널 값을 해제 시켜준다.
let value: Int? = 6
if value == 6 {
    print("value가 6입니다.")
} else {
    print("value가 6이 아닙니다.")
}


// 묵시적 옵셔널 해제
// 값을 사용할 때는 자동으로 옵셔널이 해제됨
let str = "12"
var strToInt: Int? = Int(str)
// Int() 함수는 매개변수에 정수로 변환될 수 없는 값이 오면
// nil을 반환하기 때문에 옵셔널 타입으로 선언해야 한다.
print(strToInt)
// 선언시에 ! 키워드를 사용하면 묵시적으로 옵셔널 해제를 해준다.
var strToInt2: Int! = Int("123")
print(strToInt2+1)
