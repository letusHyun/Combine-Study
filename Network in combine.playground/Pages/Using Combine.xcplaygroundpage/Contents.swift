//: [Previous](@previous)

import Foundation
import Combine

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

  func fetchProfile(userName: String) -> AnyPublisher<GithubProfile, Error> {
    let url = URL(string: "https://api.github.com/users/\(userName)")!

    let publisher = session
      .dataTaskPublisher(for: url)

    //서버에서 받은 data, response 확인
      .tryMap { result -> Data in //result는 data, response를 가지고 있는 tuple
        guard let httpResponse = result.response as? HTTPURLResponse,
              (200..<300).contains(httpResponse.statusCode) else {
          let response = result.response as? HTTPURLResponse
          let statusCode = response?.statusCode ?? -1
          throw NetworkError.responseError(statusCode: statusCode) //tryMap이므로 error 받음
        }
        return result.data
      }
      .decode(type: GithubProfile.self, decoder: JSONDecoder()) //decoding
      .eraseToAnyPublisher() //AnyPublisher 타입으로 만들어줌
    return publisher

  }
}

//Network 담당 NetworkService
//NetworkService 이용한 네트워크 작업
let networkService = NetworkService(configuration: .default)

  let subscription = networkService
    .fetchProfile(userName: "letushyun")
    .receive(on: RunLoop.main)
    .print()
    .sink { completion in
      print("completion: \(completion)")
    } receiveValue: { profile in
      print("profile: \(profile)")
    }
