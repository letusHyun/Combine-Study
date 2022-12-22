//: [Previous](@previous)

import Foundation
import Combine
import UIKit

final class SomeViewModel {
  @Published var name: String = "Jack" //Publisher 설정
  var age: Int = 20
}

final class Label {
  var text: String = ""
}

let label = Label()
let vm = SomeViewModel()
print("text: \(label.text)") //text:

//Publisher: vm.$name
vm.$name.assign(to: \.text, on: label) //Publisher에서 생성되는 data를 label 인스턴스의 text 프로퍼티에 할당함
print("text: \(label.text)") //text: Jack

vm.name = "Jason"
print("text: \(label.text)") //text: Jason




//: [Next](@next)
