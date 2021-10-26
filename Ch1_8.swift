// swift 의 if 조건문

let age: Int = 12

if age < 19{
    print("미성년자 입니다.")
}
else{
    print("성인 입니다.")
}


let animal = "cat"

if animal == "dog"{
    print("개")
}
else if animal == "cat"{
    print("고양이")
}
else{
    print("what?")
}


// switch 조건문
let color = "red"

switch color{
case "blue":
    print("파랑")
case "green":
    print("초록")
case "yellow":
    print("노랑")
default:
    print("I dont know")
}

let temperature = 30

switch temperature{
case -20...9:
    print("winter")
case 20...35:
    print("summer")
default:
    print("?")
}
