//
//  SerialListViewController.swift
//  SerialRequestList
//
//  Created by 1778948 on 20/09/21.
//

import UIKit

class SerialListViewController: UIViewController {
    @IBOutlet weak var urlTableView: UITableView!
    
    lazy var viewModel: SerialListViewModel = {
        return SerialListViewModel()
    }()
    
    var startClicked: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.viewModel.updateTable = {
//            print(self.viewModel.results)
            self.urlTableView.reloadData()
        }
    }

    @IBAction func startBtnAction(_ sender: UIBarButtonItem) {
        startClicked = true
        self.viewModel.results.removeAll()
        self.viewModel.startURLRequests()
    }
}

extension SerialListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if startClicked {
            return self.viewModel.results.count
        } else {
            return self.viewModel.urls.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UrlTableCell") as? UrlTableViewCell
        if startClicked {
            cell?.configureCellFromItem(item: self.viewModel.results[indexPath.row])
        } else {
            cell?.configureCellFromURL(urlString: self.viewModel.urls[indexPath.row])
        }
        return cell ?? UITableViewCell()
    }
    
    func tableView( _ tableView : UITableView,  titleForHeaderInSection section: Int)->String? {
       return "CONTENTS"
    }
}

extension SerialListViewController: URLSessionDownloadDelegate {
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        print(location)
        
        guard
            let url = downloadTask.originalRequest?.url  else {
            return
        }
        print(url)
        var item = self.viewModel.results.filter { item in
            return item.url == url.description
        }
        print(item)
//        download.isDownloaded = true
//        download.urlItem.imagePath = location.path
//        urlTableView.reloadRows(at: [IndexPath(index: download.urlItem.index)], with: .fade)
    }
}

