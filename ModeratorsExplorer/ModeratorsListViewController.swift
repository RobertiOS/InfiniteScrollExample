import UIKit

class ModeratorsListViewController: UIViewController, AlertDisplayer {
  private enum CellIdentifiers {
    static let list = "List"
  }
  
  @IBOutlet var indicatorView: UIActivityIndicatorView!
  @IBOutlet var tableView: UITableView!
  
  var site: String!
  
  private var viewModel: ModeratorsViewModel!
  
  private var shouldShowLoadingCell = false
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    indicatorView.color = ColorPalette.RWGreen
    indicatorView.startAnimating()
    
    tableView.isHidden = true
    tableView.separatorColor = ColorPalette.RWGreen
    tableView.dataSource = self
    
    let request = ModeratorRequest.from(site: site)
    viewModel = ModeratorsViewModel(request: request, delegate: self)
    
    viewModel.fetchModerators()    
  }
}

extension ModeratorsListViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.currentCount
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.list, for: indexPath) as! ModeratorTableViewCell
    cell.configure(with: viewModel.moderator(at: indexPath.row))
    return cell
  }
}

extension ModeratorsListViewController: ModeratorsViewModelDelegate {
  func onFetchCompleted(with newIndexPathsToReload: [IndexPath]?) {
    indicatorView.stopAnimating()
    tableView.isHidden = false
    tableView.reloadData()
  }
  
  func onFetchFailed(with reason: String) {
    indicatorView.stopAnimating()
    
    let title = "Warning".localizedString
    let action = UIAlertAction(title: "OK".localizedString, style: .default)
    displayAlert(with: title , message: reason, actions: [action])
  }
}
