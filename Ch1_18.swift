// 상속
class Vehicle {
    // final 키워드를 사용하면 오버라이딩을 막는다.
    // final var currentSpeed = 0
    
    var currentSpeed = 0
    var description: String {
        return "traveling at \(currentSpeed) miles per hour"
    }
    func makeNoise() {
        print("Super class : speaker on")
    }
}

// : 키워드로 상속받는다.
class Bicycle : Vehicle {
    var hasBasket = false
}

// 자식 클래스에 선언되지 않았지만,
// 부모 클래스에 선언된 프로퍼티를 접근할 수 있다.
var bicycle = Bicycle()
bicycle.currentSpeed = 15
bicycle.currentSpeed

class Train : Vehicle {
    // 부모 클래스의 메서드를 오버라이드 한다.
    override func makeNoise() {
        // super 키워드를 통해 super 클래스에 정의된 메서드를 호출한다.
        super.makeNoise()
        print("Train class : choo choo")
    }
}

let train = Train()
train.makeNoise()

class Car : Vehicle {
    var gear = 1
    // 프로퍼티 오버라이딩
    override var description: String {
        // super 클래스의 description 을 호출하고, 거기에 덧붙인다.
        return super.description + " in gear \(gear)"
    }
}

let car = Car()
car.currentSpeed = 30
car.gear = 2
print(car.description)

class AutomaticCar : Car {
    // 프로퍼티 오버라이딩
    override var currentSpeed: Int {
        // 프로퍼티 옵저버
        didSet {
            gear = Int(currentSpeed/10)+1
        }
    }
}

let automatic = AutomaticCar()
automatic.currentSpeed = 35
print("AutomaticCar : \(automatic.description)")

// 타입 캐스팅
class MediaItem {
    var name: String
    init(name: String){
        self.name = name
    }
}

class Movie: MediaItem {
    var director: String
    init(name: String, director: String){
        self.director = director
        super.init(name: name)
    }
}

class Song: MediaItem {
    var artist: String
    init(name: String, artist: String) {
        self.artist = artist
        super.init(name: name)
    }
}

// 업캐스팅으로 Moive와 Song을 한 Array에 담음.
let library: [MediaItem] = [
    Movie(name: "기생충", director: "봉준호"),
    Song(name: "Butter", artist: "BTS"),
    Movie(name: "올드보이", director: "박찬욱"),
    Song(name: "StrawberryMoon", artist: "IU")
]

var movieCount = 0
var songCount = 0

for item in library {
    // 타입 캐스팅 is
    if item is Movie {
        movieCount += 1
    }
    else if item is Song {
        songCount += 1
    }
}

movieCount
songCount

// 다운 타입 캐스팅 as?
// as! 은 절대적으로 확실할때만 사용한다.
for item in library {
    // MediaItem 타입의 item을 각각 Moive, Song 타입으로 다운 캐스팅 한다.
    if let movie = item as? Movie {
        print("Movie : \(movie.name)")
    }
    else if let song = item as? Song {
        print("Song : \(song.name)")
    }
}

