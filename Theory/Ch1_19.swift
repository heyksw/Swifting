var value: Int = 0
assert(value == 0, "0이 아님")

func guardTest2(value: Int?) {
    guard let value = value else {
        print("nil 입니다.")
        return
    }
    print(value)
}

guardTest2(value: 100)
guardTest2(value: nil)
