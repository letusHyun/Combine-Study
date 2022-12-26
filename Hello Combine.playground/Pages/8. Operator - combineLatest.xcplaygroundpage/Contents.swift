//: [Previous](@previous)

import Foundation
import Combine

//Basic CombineLatest
let strPublisher = PassthroughSubject<String, Never>()
let numPublisher = PassthroughSubject<Int, Never>()

// "a"           "b"      "c"
//     1      2        3       5
//     a1     a2  b2  b3   c3  c5

strPublisher.combineLatest(numPublisher).sink { str, num in //combine
  print("Receive: \(str), \(num)")
}
// 위 아래 같은 코드
//Publishers.CombineLatest(strPublisher, numPublisher).sink { (str, num) in
//  print("Receive: \(str), \(num)")
//}


strPublisher.send("a")
numPublisher.send(1)
numPublisher.send(2)

strPublisher.send("b")
numPublisher.send(3)
strPublisher.send("c")
numPublisher.send(5)


//MARK: - Advenced CombineLatest
  //CombineLatest는 Output타입이 달라도 됨
let userNamePublisher = PassthroughSubject<String, Never>()
let passwordPublisher = PassthroughSubject<String, Never>()

let validatedCredentialsSubscription = userNamePublisher.combineLatest(passwordPublisher)
  .map { (userName, password) -> Bool in
    return !userName.isEmpty && !password.isEmpty && password.count > 12
  }
  .sink { valid in
    print("Credential valid?: \(valid)")
  }

userNamePublisher.send("JasonLee")
passwordPublisher.send("weakpw")
passwordPublisher.send("verystrongpassword")


//MARK: - Merge
  // Merge는 Output 타입이 같아야 함
let publisher1 = [1, 2, 3, 4, 5].publisher
//let publisher2 = ["300", "400", "500"].publisher //publishser 타입이 다르면 error
let publisher2 = [300, 400, 500].publisher

let mergePublisherSubscription = publisher1.merge(with: publisher2)
  .sink {
    print("Merge: subscription received value: \($0)")
  }
//위 아래 같은 코드
//Publishers.Merge(publisher1, publisher2)
//  .sink {
//    print("Merge: subscription received value: \($0)")
//  }


//: [Next](@next)
