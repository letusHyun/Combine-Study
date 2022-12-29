//: [Previous](@previous)

import Foundation

enum NetworkError: Error {
  case invalidRequest
  case transportError(Error) //unnamed tuple 형식의 연관값
  case responseError(statusCode: Int) //named tuple 형식의 연관값
  case noData
  case decodingError(Error)
}

struct GithubProfile: Codable {
  let login: String
  let avatarUrl: String
  let htmlUrl: String
  let followers: Int
  let following: Int
  
  enum CodingKeys: String, CodingKey {
    case login
    case avatarUrl = "avatar_url"
    case htmlUrl = "html_url"
    case followers
    case following
  }
}

final class NetworkService {
  
  let session: URLSession
  
  init(configuration: URLSessionConfiguration) {
    session = URLSession(configuration: configuration)
  }
  
  func fetchProfile(userName: String, completion: @escaping (Result<GithubProfile, NetworkError>) -> Void) {
    let url = URL(string: "https://api.github.com/users/\(userName)")!
    let task = self.session.dataTask(with: url) { data, response, error in
      if let error = error {
//        completion(Result<GithubProfile, NetworkError>.failure(NetworkError.transportError(error)))
        completion(.failure(.transportError(error)))
        return
      }
      
      if let httpResponse = response as? HTTPURLResponse,
         !(200..<300).contains(httpResponse.statusCode) {
        completion(.failure(.responseError(statusCode: httpResponse.statusCode)))
        return
      }
      
      guard let data = data else {
        completion(.failure(.noData))
        return
      }
      
      do {
        let decoder = JSONDecoder()
        let profile = try decoder.decode(GithubProfile.self, from: data)
        completion(.success(profile))
      } catch let error as NSError {
        completion(.failure(.decodingError(error)))
      }
    }
    task.resume()
  }
}

//Network 담당 NetworkService
//NetworkService 이용한 네트워크 작업
let networkService = NetworkService(configuration: .default)

networkService.fetchProfile(userName: "letushyun") { result in
  switch result {
  case .success(let profile):
    print("Profile: \(profile)")
  case .failure(let error):
    print("Error: \(error)")
  }
}
 

//: [Next](@next)
