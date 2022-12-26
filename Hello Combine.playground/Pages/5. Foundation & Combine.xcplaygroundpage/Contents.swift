//: [Previous](@previous)

import Foundation
import Combine
import UIKit

//DataModel
struct SomeDecodable: Decodable { }

/* URLSessionTask Publisher and JSON Decoding Operator */
URLSession.shared.dataTaskPublisher(for: URL(string: "https://www.google.com")!)
  .map { data, response in
    return data }
  .decode(type: SomeDecodable.self, decoder: JSONDecoder())
  
/* Notification Publisher */
let center = NotificationCenter.default
let noti = Notification.Name("MyNoti")

//Publisher 생성
//default의 name에 해당하는 알림이 post 되면 그에 따라 알림을 제공
let notiPublisher = center.publisher(for: noti, object: nil)
let subscription = notiPublisher.sink { _ in //subscribe함 -> subscription 관계 형성
  print("Noti Received")
}

center.post(name: noti, object: nil) //Publisher가 post로 Subscriber에게 알림
subscription.cancel() //구독 해제


/* KeyPath binding to NSObject instance */
let ageLabel = UILabel()
print("text: \(ageLabel.text)") //nil



Just(28) //Publisher
  .map { "Age is \($0)"}
  .assign(to: \.text, on: ageLabel) //binding

print("text: \(ageLabel.text)")
print("-----------------------")

/* Timer */
let timerPublisher = Timer
  .publish(every: 1, on: .main, in: .common)
  .autoconnect() //Subscriber가 Publisher를 구독했을 때 알아서 동작하도록 처리해줌

let subscription2 = timerPublisher.sink { time in
  print("time: \(time)")
}

DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
  subscription2.cancel() //5초 후, 구독 해제
}


