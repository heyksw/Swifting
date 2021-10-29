// 스위프트 고차함수

// map
let numbers = [0,1,2,3]
let mapArray = numbers.map{ (num) -> Int in
    return num * 2
}
print(mapArray)
// -> [0, 2, 4, 6]
// 클로저 간소화 표현
let mapArray2 = numbers.map { $0 * 2 }
print(mapArray2)    // -> [0, 2, 4, 6]


// filter
let intArray = [10, 5, 20, 13, 4]
let filterArray = intArray.filter { (num) -> Bool in
    return num > 5
}
print(filterArray)  // -> [10, 20, 13]

// 클로저 간소화 표현
let filterArray2 = intArray.filter { $0 > 5 }
print(filterArray2) // -> [10, 20, 13]


// reduce (축소하다)
// 초기값이 0인 상태에서 모든 원소 더하기
// 컨테이너 내부의 콘텐츠를 "합" 으로 통합한다.
let someArray = [1,2,3,4,5]
let addResult = someArray.reduce(0) {
    (result: Int, element: Int) -> Int in
    print("\(result) + \(element)")
    return result + element
}

print(addResult)    // -> 15

// 초기값이 1인 상태에서 모든 원소 곱하기
// 컨테이너 내부의 콘텐츠를 "곱" 으로 통합한다.
let multiResult = someArray.reduce(1, {(result: Int, elem: Int) -> Int in return result * elem
})

print(multiResult)  // -> 120

// 클로저 축약
let multiResult2 = someArray.reduce(1) { $0 * $1 }
print(multiResult2) // -> 120
