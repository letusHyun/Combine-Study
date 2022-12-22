//: [Previous](@previous)

import Foundation
import Combine

//let just = Just(1000) //Publisher
//let subscription1 = just.sink { value in //sink: Subscriber
//  print("Received Value: \(value)")
//}
//print("-------------------------")
//let arrayPublisher = [1,3,5,7,9].publisher
//let subscription2 = arrayPublisher.sink { value in //sink: Subscriber
//  print("Received Value: \(value)")
//}
//print("-------------------------")
//class MyClass {
//  var property: Int = 0 {
//    didSet {
//      print("Did set property to \(property)")
//    }
//  }
//}
//
//let object = MyClass()
//let subscription3 = arrayPublisher.assign(to: \.property, on: object)
//print("Final Value: \(object.property)")
//object.property = 3
//: [Next](@next)

let just = Just(100)
let subscription1 = just.sink { value in
  print("just value: \(value)")
}
print("---------------")
let publisher = [1, 2, 3, 4, 5, 6].publisher
let subscription2 = publisher.sink { value in
  print("publisher value: \(value)")
}
print("---------------")
class CustomClass {
  var property: Int = 11 {
    didSet {
      print("didSet property: \(property)")
    }
  }
}

let custom = CustomClass()
let subscription3 = publisher.assign(to: \.property, on: custom)











