import UIKit
//enum
enum Direction: CustomStringConvertible {
    case North
    case South
    case East
    case West
    
    var description: String {
        switch self {
        case .North:
            return "North"
        case .South:
            return "South"
        case .East:
            return "East"
        case .West:
            return "West"
        }
    }
}


func printDirection(_ direction: Direction) {
    print(direction.description)
}

print(Direction.North)
print(Direction.South)
print(Direction.East)
print(Direction.West)

typealias Weight = Float

let mass1: Weight =  150.0
let mass2: Weight =   350.0

let total: Weight = mass1 + mass2
print(total)



protocol Animal {
    var name: String { get set }
    var color: String { get set }
    func makeSound()
}

class Cat: Animal {
    var name: String = "Billi😺"
    var color: String = "Bhura"
    func makeSound() {
        print("Meow!!! Meow!!!")
    }
}

let cat = Cat()
print(cat.name, cat.color)
cat.makeSound()

func aGuard() {
    guard false else {
        print("This block is run......")
        return
    }
    
    print("This block will never run...")
}

aGuard()


func aDefer() {
    defer {
        print("Put me in front I will fight at end!!!!")
    }
    
    print("I will fight first")
}

aDefer()

func swapWithOutTempTupleDestructuring() {
    var a = 10
    var b = 20
    print("Before a= \(a), b= \(b)")
    (a, b) = (b, a)
    print("after a= \(a), b= \(b)")

}

swapWithOutTempTupleDestructuring()


struct Vec3D<T> {
    let x, y, z: T
    
    init(x: T, y: T, z: T) {
        self.x = x
        self.y = y
        self.z = z
    }
    
    func printValues() {
        print("(\(x), \(y), \(z))")
    }
}

let vd = Vec3D(x: 2, y: 3, z: 5)
vd.printValues()
let vdf = Vec3D(x: 2.3, y: 3.5, z: 5.8)
vdf.printValues()

//Example of stored Properties

class PoundKG {
    var kg: Float = 0.0
    var pounds: Float {
        get {
            return ( kg * 2.205 )
        }
        set(newWeight) {
            kg = newWeight / 2.205
        }
    }
}

let poundkg = PoundKG()
poundkg.kg = 100.0

print(poundkg.pounds)
poundkg.pounds = 315
print(poundkg.kg)

class Fruit {
    var name: String
    init(name: String) {
        self.name = name
    }
}

let fruit1 = Fruit(name: "Mango")
let fruit2 = Fruit(name: "Mango")
print("fruit1 == fruit2: \(fruit1.name == fruit2.name)")
print("fruit1 === fruit2: \(fruit1 === fruit2)")
let fruit3 = fruit1
print("fruit1 == fruit3: \(fruit1.name == fruit3.name)")
print("fruit1 === fruit3: \(fruit1 === fruit3)")
fruit3.name = "Banana"
print("fruit1 == fruit2: \(fruit1.name == fruit2.name)")


func printNested() {
    func printMe() {
        print("Hello printMe")
    }
    printMe()
}

printNested()

//Mutating
struct newFruit {
    var type: String
    mutating func convertToBanana() {
        self.type = "Banana"
    }
}

var fruit = newFruit(type: "Apple")
print(fruit.type)
fruit.convertToBanana()
print(fruit.type)


//Regualar closure
func i_Will(_ perform_action: () -> Void) {
    perform_action()
}

i_Will {
    print("Hello yes you will Regular!!!!")
}

func i_will_auto(_ perform_action: @autoclosure () -> Void) {
    perform_action()
}


i_will_auto(print("Yes you will auto!!!"))


//operator overloading
struct oneMoreFruit {
    var name: String
    init(_ name: String) {
        self.name = name
    }
}

func ==(rhs: oneMoreFruit, lhs: oneMoreFruit) -> Bool {
    return rhs.name == lhs.name
}

let f1 = oneMoreFruit("Banana")
let f2 = oneMoreFruit("Mango")
let f3 = oneMoreFruit("Mango")

print(f1 == f2)
print(f2 == f3)
print(f1 == f3)


class FruitClass {
    var name: String
    
    init(_ name: String) {
        self.name = name
    }
}

func  ==(rhs: FruitClass, lhs: FruitClass) -> Bool {
    return rhs.name == lhs.name
}

let f4 = FruitClass("Mango")
let f5 = FruitClass("Mango")
let f6 = f5

print("f4 === f5: \(f4 === f5)")
print("f4 === f6: \(f4 === f6)")
print("f5 === f6: \(f5 === f6)")


print("f4 == f5: \(f4 == f5)")
print("f4 == f6: \(f4 == f6)")
print("f5 == f6: \(f5 == f6)")

struct Person {
    var weight: Double
    var height: Double
    
    lazy var BMIIndex: Double = {
        return weight / pow(height, 2)
    }()
}

var dilip = Person(weight: 84.0, height: 1.66)
print(dilip.BMIIndex)

let dailyTemp = [101, 102, 103, 105]
let isItHot = dailyTemp.allSatisfy({ $0 > 100 })
print("isItHot \(isItHot)")
