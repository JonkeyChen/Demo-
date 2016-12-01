////: Playground - noun: a place where people can play
//
//import UIKit
//
//var str = "Hello, playground"
//
////1.值永远不会被隐式转换为其他类型。如果你需要把一个值转换成其他类型，请显式转换。
//let label = "The width is"
//let width = 94
//let widthLabel = label + String(width)
//
////2.有一种更简单的把值转换成字符串的方法：把值写到括号中，并且在括号之前写一个反斜杠
//let apples = 3
//let oranges = 5
//let appleSummary = "I have \(apples) apples."
//let fruitSummary = "I have \(apples + oranges) pieces of fruit."
////eg:练习：使用\()来把一个浮点计算转换成字符串，并加上某人的名字，和他打个招呼。
//let number = 4
//let name   = "Jonkey"
//let combineString = "\(name) has \(number) apples"
//
////3.使用方括号[]来创建数组和字典，并使用下标或者键（key）来访问元素。
//var shoppingList = ["catfish", "water", "tulips", "blue paint"]
//shoppingList[1] = "bottle of water"
//
//var occupations = [ "Malcolm": "Captain", "Kaylee": "Mechanic", ]
//occupations["Jayne"] = "Public Relations"
//
////4.要创建一个空数组或者字典，使用初始化语法。
//let emptyArray = [String]()
//let emptyDictionary = Dictionary<String, Float>()
//
////5.控制流
////使用if和switch来进行条件操作，使用for-in、for、while和do-while来进行循环。包裹条件和循环变量括号可以省略，但是语句体的大括号是必须的。
//let individualScores = [75, 43, 103, 87, 12]
//var teamScore = 0
//for score in individualScores {
//    if score > 50 {
//        teamScore += 3
//    } else {
//        teamScore += 1
//    }
//}
//teamScore
////在if语句中，条件必须是一个布尔表达式——像if score { ... }这样的代码是错误的。
//
////6.你可以一起使用if和let来处理值缺失的情况。有些变量的值是可选的。一个可选的值可能是一个具体的值或者是nil，表示值缺失。在类型后面加一个问号来标记这个变量的值是可选的。
//var optionalString: String? = "Hello"
//optionalString == nil
//
//var optionalName: String? = "John Appleseed"
//var greeting = "Hello!"
//
//if let name = optionalName {
//    greeting = "Hello, \(name)"
//} else {
//    greeting = "Hello, \(name)"
//}
//
//
////7.switch支持任意类型的数据以及各种比较操作——不仅仅是整数以及测试相等。
//let vegetable = "red pepper"
//
//switch vegetable {
//case "celery":
//    let vegetableComment = "Add some raisins and make ants on a log."
//case "cucumber", "watercress":
//    let vegetableComment = "That would make a good tea sandwich."
//case let x where x.hasSuffix("pepper"):
//    let vegetableComment = "Is it a spicy \(x)?"
//default:
//    let vegetableComment = "Everything tastes good in soup."
//}
////运行switch中匹配到的子句之后，程序会退出switch语句，并不会继续向下运行，所以不需要在每个子句结尾写break。
//
////8.可以使用for-in来遍历字典，需要两个变量来表示每个键值对。
//let interestingNumbers = [
//    "Prime": [2, 3, 5, 7, 11, 13],
//    "Fibonacci": [1, 1, 2, 3, 5, 8],
//    "Square": [1, 4, 9, 16, 25],
//]
//
//var largest = 10
//var maxKey = ""
//
//for (kind, numbers) in interestingNumbers {
//    for number in numbers {
//        if number > largest {
//            largest = number
//            maxKey = kind
//        }
//    }
//}
//largest
//maxKey
//
////9可以在循环中使用..来表示范围，也可以使用传统的写法，两者是等价的：
//for i in 1...6 {
//    print(i)
//}
//
//for i in 1..<6 {
//    
//    for var j in 1...(6-i) {
//        
//        print(" ")
//    }
//    
//    for var j in 1...(2*i - 1) {
//    
//        print("*")
//    }
//}
//
////10函数和闭包
////使用func来声明一个函数，使用名字和参数来调用函数。使用->来指定函数返回值。
//func great(name:String ,day:String) -> String {
//    return "hello \(name) ,tooday is \(day)"
//}
//great("Jonkey", day: "Tuesday")
//
////11.使用一个元组来返回多个值。
//func getGasPrices(number1:Double,number2:Double,number3:Double) -> (Double, Double, Double) {
//    return (number1*10,number2*5, number3*2)
//}
//let elementGasPrices = getGasPrices(12.3,number2: 11.2,number3: 10.5)
//elementGasPrices.0
//elementGasPrices.1
//elementGasPrices.2
//
////12.函数的参数数量是可变的，用一个数组来获取它们：
//func sumOf(numbers: Int...) -> Int {
//    var sum = 0
//    for number in numbers {
//        sum += number
//    }
//    return sum
//}
//sumOf()
//sumOf(42, 597, 12)
//
////计算参数平均值的函数
//func avergaeOf(numbers:Int...) -> Int {
//    var sum = 0
//    let count = numbers.count
//    for number in numbers {
//        sum += number;
//    }
//    return sum/count
//}
//avergaeOf(10,20,30,40)
//
////函数是一等公民，这意味着函数可以作为另一个函数的返回值
//func makeIncrementer() -> (Int -> Int) {
//    func addOne(number: Int) -> Int {
//        return 1 + number
//    }
//    return addOne
//}
//var increment = makeIncrementer()
//increment(7)
//
////函数也可以当做参数传入另一个函数
//func hasAnyMatches(list: [Int], condition: Int -> Bool) -> Bool {
//    for item in list {
//        if condition(item) {
//            return true
//        }
//    }
//    return false
//}
//func lessThanTen(number: Int) -> Bool {
//    return number < 10
//}
//var numbers = [20, 19, 7, 12]
//hasAnyMatches(numbers, condition: lessThanTen)
//
////12.函数实际上是一种特殊的闭包，你可以使用{}来创建一个匿名闭包。使用in来分割参数并返回类型。
//numbers.map({(number: Int) -> Int in
//    
//    let result = 3 * number
//    
//    return result
//})
//
//
////13.这个版本的Shape类缺少了一些重要的东西：一个构造函数来初始化类实例。使用init来创建一个构造
//class NamedShape: NSObject {
//    var numbers = 0
//    var name: String
//    
//    init(name: String) {
//        self.name = name
//    }
//    func simpleDescription() -> String {
//        return "A shape with \(numbers) sides."
//    }
//}
//
//var shape = NamedShape.init(name: "Jonkey")
//shape.numbers = 2
//shape.simpleDescription()
//
////子类如果要重写父类的方法
////需要用override标记——如果没有添加override就重写父类方法的话编译器会报错。编译器同样会检测override标记的方法是否确实在父类中
//class Square: NamedShape {
//    var sideLength: Double
//
//    init(sideLength: Double, name: String) {
//        self.sideLength = sideLength
//        super.init(name: name)
//        numbers = 4
//    }
//    
//    func area() -> Double {
//        return sideLength * sideLength
//    }
//    
//    override func simpleDescription() -> String {
//        return "A square with \(numbers) sides of \(sideLength) length ."
//    }
//}
//let test = Square(sideLength: 5.2, name: "my test square")
//test.area()
//test.simpleDescription()
//
////创建NamedShape的另一个子类Circle，构造器接收两个参数，一个是半径一个是名称，实现area和describe方法。
////属性可以有 getter 和 setter 。
//class EquilateralTriangle: NamedShape {
//    var sideLength: Double = 0.0
//    init(sideLength: Double, name: String) {
//        self.sideLength = sideLength
//        super.init(name: name)
//        numbers = 3
//    }
//    var perimeter: Double {
//        get {
//            return 3.0 * sideLength
//        }
//        set {
//            sideLength = newValue / 3.0
//        }
//    }
//    override func simpleDescription() -> String {
//        return "An equilateral triagle with sides of length \(sideLength)."
//    }
//}
//var triangle = EquilateralTriangle(sideLength: 3.1, name: "a triangle")
//triangle.perimeter
//triangle.perimeter = 9.9
//triangle.sideLength
//
//
////15.类中的方法和一般的函数有一个重要的区别，函数的参数名只在函数内部使用，但是方法的参数名需要在调用的时候显式说明（除了第一个参数）。
////默认情况下，方法的参数名和它在方法内部的名字一样，不过你也可以定义第二个名字，这个名字被用在方法内部。
//class Counter {
//    var count: Int = 0
//    func incrementBy(amount: Int, numberOfTimes times: Int) {
//        count += amount * times
//    }
//}
//var counter = Counter()
//counter.incrementBy(2, numberOfTimes: 7)
//
////处理变量的可选值时，你可以在操作（比如方法、属性和子脚本）之前加?。
////如果?之前的值是nil，?后面的东西都会被忽略，并且整个表达式返回nil。否则，?之后的东西都会被运行。在这两种情况下，整个表达式的值也是一个可选值。
//let optionalSquare: Square? = Square(sideLength: 2.5, name: "optional square")
//let sideLength = optionalSquare?.sideLength
//
//
////16.枚举和结构体
////使用enum来创建一个枚举。就像类和其他所有命名类型一样，枚举可以包含方法。
//
//enum Rank: Int {
//    case Ace = 1
//    case Two, Three, Four, Five, Six, Seven, Eight, Nine, Ten
//    case Jack, Queen, King
//    func simpleDescription() -> String {
//        switch self {
//        case .Ace:
//            return "ace"
//        case .Jack:
//            return "jack"
//        case .Queen:
//            return "queen"
//        case .King:
//            return "king"
//        default:
//            return ""
//        }
//    }
//}
//let rank = Rank.Ace
//
////枚举的成员值是实际值，并不是原始值的另一种表达方法。实际上，如果原始值没有意义，你不需要设置。
//enum Suit {
//    case Spades, Hearts, Diamonds, Clubs
//    func simpleDescription() -> String {
//        switch self {
//        case .Spades:
//            return "spades"
//        case .Hearts:
//            return "hearts"
//        case .Diamonds:
//            return "diamonds"
//        case .Clubs:
//            return "clubs"
//        }
//    }
//}
//let hearts = Suit.Hearts
//let heartsDescription = hearts.simpleDescription()
//
////使用struct来创建一个结构体。结构体和类有很多相同的地方，比如方法和构造器。它们结构体之间最大的一个区别就是 结构体是传值，类是传引用。
//struct Card {
//    var rank: Rank
//    var suit: Suit
//    //func simpleDescription() -> String {
//        //return "The \(rank.simpleDescription()) of \
//        //(suit.simpleDescription())"
//    //}
//}
//let threeOfSpades = Card(rank: .Three, suit: .Spades)
////let threeOfSpadesDescription = threeOfSpades.simpleDescripti
//
////17.接口和扩展
////使用protocol来声明一个接口。
//protocol ExampleProtocol {
//    var simpleDescription: String { get }
//    mutating func adjust() }
////类、枚举和结构体都可以实现接口。
//class SimpleClass: ExampleProtocol {
//    var simpleDescription: String = "A very simple class."
//    var anotherProperty: Int = 69105
//    func adjust() {
//        simpleDescription += " Now 100% adjusted."
//    }
//}
//var a = SimpleClass()
//a.adjust()
//
//struct SimpleStructure: ExampleProtocol {
//    var simpleDescription: String = "A simple structure"; mutating func adjust() {
//        simpleDescription += " (adjusted)"
//    }
//}
//var b = SimpleStructure()
//b.adjust()
//let bDescription = b.simpleDescription
//
