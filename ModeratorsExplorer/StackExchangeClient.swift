import Foundation

final class StackExchangeClient {
  private lazy var baseURL: URL = {
    return URL(string: "http://api.stackexchange.com/2.2/")!
  }()
  
  let session: URLSession
  
  init(session: URLSession = URLSession.shared) {
    self.session = session
  }
  
  func fetchModerators(with request: ModeratorRequest, page: Int, completion: @escaping (Result<PagedModeratorResponse, DataResponseError>) -> Void) {
    
  }
}
