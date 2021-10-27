let constant: String = "차후 변경이 불가능한 상수 let"
var variable: String = "차후 변경이 가능한 변수 var"

variable = "변수는 이렇게 차후에 다른 값을 할당할 수 있지만"
// constant = "상수는 차후에 다른 값을 변경할 수 없습니다."

// 나중에 할당하려고 하는 상수나 변수는 타입을 꼭 명시해주어야 합니다.
let sum: Int
let inputA: Int = 100
let inputB: Int = 200

// 상수의 첫 할당
sum = inputA + inputB

// sum = 1 // 그 이후에는 다시 값을 바꿀 수 없습니다. 오류발생

var nickName: String

nickName = "ksw"

// 변수는 다시 다른 값을 할당해도 문제가 없다.
nickName = "Kim Sang Woo"
