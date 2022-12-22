//: [Previous](@previous)

import Foundation
import Combine

//Subject(Publisher)
let subject = PassthroughSubject<String, Never>() //Output, Failure

//Subscriber가 Publisher에게 붙음 -> Subscription 관계 형성
let subscription1 = subject
  .print("[Debug]") //debugging print
  .sink { value in
  print("Subscriber received value: \(value)")
}

//Publisher가 Subscriber에게 data 보냄
subject.send("Hello")
subject.send("Hello again!")
subject.send("Hello for the last time")

subject.send(completion: .finished) //Subject가 구독 관계 끊음
//subscription1.cancel() //Subscription 자체로 구독관계 끊음
subject.send("Hello ?? :(")



//: [Next](@next)
