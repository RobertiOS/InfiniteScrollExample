import Foundation

protocol ModeratorsViewModelDelegate: class {
  func onFetchCompleted(with newIndexPathsToReload: [IndexPath]?)
  func onFetchFailed(with reason: String)
}

final class ModeratorsViewModel {
  private weak var delegate: ModeratorsViewModelDelegate?
  
  private var moderators: [Moderator] = []
  private var currentPage = 1
  private var total = 0
  private var isFetchInProgress = false
  
  let client = StackExchangeClient()
  let request: ModeratorRequest
  
  init(request: ModeratorRequest, delegate: ModeratorsViewModelDelegate) {
    self.request = request
    self.delegate = delegate
  }
  
  var totalCount: Int {
    return total
  }
  
  var currentCount: Int {
    return moderators.count
  }
  
  func moderator(at index: Int) -> Moderator {
    return moderators[index]
  }
  
  func fetchModerators() {
    
  }
}
