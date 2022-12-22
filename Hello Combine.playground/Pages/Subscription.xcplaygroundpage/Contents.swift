//: [Previous](@previous)

import Foundation
import Combine

//Subject(Publisher)
let subject = PassthroughSubject<String, Never>() //Output, Failure

let subscription1 = subject.sink { value in
  print("")
}
//: [Next](@next)
