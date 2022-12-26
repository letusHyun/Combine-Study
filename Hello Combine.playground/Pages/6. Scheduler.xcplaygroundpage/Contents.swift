//: [Previous](@previous)

import Foundation
import Combine

//Scheduler는 element가 생성된 쓰레드와 동일한 쓰레드를 사용함

let arrayPublisher = [1, 2, 3].publisher
let queue = DispatchQueue(label: "custom")

let subscription = arrayPublisher
  .subscribe(on: queue) //upstream, arrayPublisher부터 queue 변경시킴
  .map { value -> Int in //operator
    print("transform: \(value), thread: \(Thread.current)")
    return value
  }
  .receive(on: DispatchQueue.main) //downstream, 데이터를 main thread에서 받음
  .sink { value in //subscribe -> subscription
  print("Receive value: \(value), thread: \(Thread.current)")
}

//: [Next](@next)
