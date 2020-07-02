//
//  PhotoDetailsViewController.swift
//  PhotoLib
//
//  Created by Marat Saytakov on 6/30/20.
//

import UIKit

/// This is explicitly made from a Table View Controller for demo purposes.
final class PhotoDetailsViewController: UITableViewController {
  
  var viewModel: PhotoDetailsViewModel!

  let photoDetailsTansitioningDelegate =  PhotoDetailsTansitioningDelegate()

  override func viewDidLoad() {
    super.viewDidLoad()
    
    assert(viewModel != nil)

    tableView.backgroundColor = .systemGray6
    
    tableView.delegate = self
    tableView.dataSource = self
    
    tableView.register(UINib(nibName: "PhotoDetailTableViewCell", bundle: nil),
                       forCellReuseIdentifier: PhotoDetailTableViewCell.reuseIdentifier)

    let gestureRec = UITapGestureRecognizer(target: self, action: #selector(close))
    gestureRec.numberOfTouchesRequired = 1
    gestureRec.cancelsTouchesInView = true
    view.addGestureRecognizer(gestureRec)
  }

  @objc func close(sender: Any) {
    dismiss(animated: true, completion: nil)
  }

  // MARK: - UITableViewDelegate, UITableViewDataSource
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.numberOfRows
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(
      withIdentifier: PhotoDetailTableViewCell.reuseIdentifier, for: indexPath) as? PhotoDetailTableViewCell else {
        fatalError("Unregistered table view cell")
    }

    let cellInfo = viewModel.cellTexts(at: indexPath)
    
    cell.textLabel?.text = cellInfo.title
    cell.detailTextLabel?.text = cellInfo.value
    
    return cell
  }

  override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    viewModel.titleForHeaderInSection(section)
  }

}
