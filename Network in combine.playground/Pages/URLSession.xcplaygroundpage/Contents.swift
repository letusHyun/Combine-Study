//: [Previous](@previous)

import Foundation

//configuration ->  URLSession -> URLSession.dataTask
let configuration = URLSessionConfiguration.default
let session = URLSession(configuration: configuration)
let url = URL(string: "https://api.github.com/users/letushyun")!
let task = session.dataTask(with: url) { data, response, error in
  guard let httpResponse = response as? HTTPURLResponse, (200..<300).contains(httpResponse.statusCode) else {
    print("--> response \(response)")
    return
  }
  
  guard let data = data else { return }
  
  guard let result = String(data: data, encoding: .utf8) else { return }
  print(result)
}

task.resume()





//: [Next](@next)