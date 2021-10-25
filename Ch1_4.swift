var someBool: Bool = true
someBool = false
// someBool = 0
// someBool = 1 -> 스위프트에서는 이것을 Int로 인식하기 때문에 오류.

var someInt: Int = 100
// someInt = 100.1 -> double 타입을 넣으면 오류.

var someUInt: UInt = 100
// someUInt = -100 -> Unsigned Integer에는 음수를 넣을 수 없음. 오류.

// someUInt = someInt -> someInt 에는 100이 담겨있었다.
// 그래서 가능하다고 생각할 수 있지만 "안된다."
// 스위프트는 데이터 타입에 매우 엄격한 언어이다.

var someFloat: Float = 3.14
someFloat = 3	// 이것은 가능하다.

var someDouble: Double = 3.14
someDouble = 3	// 가능

// someDouble = someFloat	-> 오류.

// Character 도 큰 따옴표를 사용한다. 유니코드의 모든 문자를 사용가능하다.
var someCharacter: Character = "가"

var someString: String = "하하하"
someString = someString + "웃자"	// 문자열 덧셈이 가능하다.

// String 형도 Character 형을 받아올 수 없다. 매우 엄격하다.
