//: Playground - noun: a place where people can play

import UIKit


struct User {
    var age : Int
    var weight : Int
    var height : Int
    mutating func gainWeight(newWeight: Int) {
        weight += newWeight
    }
}

var user = User(age: 15, weight: 150, height: 170)
user.gainWeight(newWeight: 100)

protocol Vehicle {    
    var numberOfWheels: Int {get}
    var color: UIColor {get set}
    mutating func changeColor()
}

struct MyCar: Vehicle {
    let numberOfWheels = 4
    var color = UIColor.blue
    mutating func changeColor() {
        color = UIColor.red
    }
}