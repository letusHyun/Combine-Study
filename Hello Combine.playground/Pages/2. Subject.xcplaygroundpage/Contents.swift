import UIKit
import Combine
/*
 Subject
 send메소드를 통해 subscriber에게 data 전송
 */


//PassthroughSubject
let relay = PassthroughSubject<String, Never>() //<Output, Error>
let subscription1 = relay.sink { value in
  print("subscription1 received value: \(value)")
}
relay.send("Hello") //subscriber에게 data 전송
relay.send("World!")
print("-------------------------------------")

//CurrentValueSubject
let variable = CurrentValueSubject<String, Never>("") //have to have value

variable.send("Initial text")

let subscription2 = variable.sink { value in
  print("subscription2 received value: \(value)")
}
variable.send("More text")
variable.value = "value send"
print("-------------------------------------")
let publisher = ["Here", "we", "go"].publisher
publisher.subscribe(relay) //publisher가 subject(publisher)에게 data를 전달함
print("-------------------------------------")
publisher.subscribe(variable) //publisher가 subject(publisher)에게 data를 전달함
