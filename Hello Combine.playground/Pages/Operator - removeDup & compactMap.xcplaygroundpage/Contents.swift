//: [Previous](@previous)

import Foundation
import Combine

var subscriptions = Set<AnyCancellable>()

//MARK: - removeDuplicates
//중복 제거
let words = "hey hey there! Mr Mr ?"
  .components(separatedBy: " ")
  .publisher

words
  .removeDuplicates() //중복 제거
  .sink {
    print($0)
  }.store(in: &subscriptions)

print("----------------------------")

//MARK: - compactMap
//publisher stream에 nil을 제거하고, nil이 아닌 경우만 downstream에 publish
let strings = ["a", "1.24", "3", "def", "45", "0.23"].publisher

strings
  .compactMap { Float($0) } //nil 제거
  .sink {
    print($0)
  }.store(in: &subscriptions)
  
print("----------------------------")
//MARK: - ignoreOutput
let numbers = (1...10_000).publisher

numbers
  .ignoreOutput() //output을 무시하므로 데이터가 들어오지 않음
  .sink(receiveCompletion: { print("Completed with: \($0)") }
        , receiveValue: { print($0) })
  .store(in: &subscriptions)


print("----------------------------")
//prefix
//개수 제한
let tens = (1...10).publisher

tens
  .prefix(2) //2개만 publish
  .sink(receiveCompletion: { print("Completed with: \($0)") }
        , receiveValue: { print($0) })
  .store(in: &subscriptions)




//: [Next](@next)
