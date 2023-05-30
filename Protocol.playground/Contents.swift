import UIKit

//Gettable Constant Property
protocol FullyNamed {
    var fullName: String { get }
}

struct Detective: FullyNamed {
    let fullName: String
}

let hercule = Detective(fullName: "Hercule Poirot")
print(hercule.fullName)

//Getable Varaible Property

struct Detective1: FullyNamed {
    var fullName: String
}

var bond = Detective1(fullName: "Bond")
print(bond.fullName)
bond.fullName = "James Bond"
print(bond.fullName)

//Gettable Computed Property

struct Detective2: FullyNamed {
    fileprivate var name: String
    var fullName: String {
        return name
    }
}

let batman = Detective2(name: "Bruce Wayne")
print(batman.fullName)

//Gettable Private set

public struct Detective3: FullyNamed {
    public private(set) var fullName: String
    public init(fullName: String) {
        self.fullName = fullName
    }
    mutating public func renameWith(fullName: String) {
        self.fullName = fullName
    }
}

var holems = Detective3(fullName: "Holmes")
print(holems.fullName)
holems.renameWith(fullName: "Sherlock Holmes")
print(holems.fullName)


//Gettable Settable coputed property
struct Detective4: FullyNamed {
    fileprivate var name: String
    var fullName: String {
        get {
            return name
        }
        set {
            name = newValue
        }
    }
}

var payne = Detective4(name: "Payne")
print(payne.fullName)
payne.fullName = "Max Payne"
print(payne.fullName)


//Gettable Settable Constant property
protocol fullyNamed1 {
    var fullName: String { get set }
}

struct Detective5: fullyNamed1 {
    var fullName: String // If set it 'let' give error
    
}

let rorschach = Detective5(fullName: "Walter Joseph Kovacs")
print(rorschach.fullName)


//Gettable and settable only get define

struct Detective6: fullyNamed1 {
    fileprivate var name: String
    var fullName: String {
        get{
            return name
        }
        set {
            name = newValue //get and set both implementatuon complsory
        }
    }
}

var constantine = Detective6(name: "John Constantine")
print(constantine.fullName)

//Typecasting with protocol


protocol FullyNamedFinal {
    var firstName: String { get }
    var lastName: String { get set }
}
struct SuperHero: FullyNamedFinal {
    var firstName: String = "Super"
    var lastName: String = "Man"
}

var dcHero = SuperHero()
print(dcHero)
dcHero.firstName = "Bat"
dcHero.lastName = "Girl"
print(dcHero)

var newDcHero: FullyNamedFinal = SuperHero()
print(newDcHero)
//newDcHero.firstName = "Bat"
newDcHero.lastName = "Woman"
print(newDcHero)
