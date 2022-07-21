//
//  ViewController.swift
//  Newsfeed
//
//  Created by riya singhal on 27/06/22.
//
// UI
// TABLEVIEW
// CUSTOM CELL
// API Calling




import ReactiveSwift
import UIKit
protocol StaticReuseIdentifierProvider {
    static var reuseIdentifier: String { get }
}



protocol ViewControllerDelegate : AnyObject
{
   
    var numberOfSections : Int {get}
    func numberOfItems(at section: Int) -> Int
    func item(at indexPath : IndexPath) -> Any
    
    func getNews()
}

class ViewController: UIViewController {
    let apiKey = "89b889f4e7ca4dce818f9436f30aa34f"
    
   @IBOutlet weak var searchView: UISearchBar!
    @IBOutlet weak var tableview : UITableView!
    var articals:[Article]?
    var filtersArticals:[Article]?
    var disposable = CompositeDisposable([])
    var viewModel : ViewControllerDelegate!
    
    // life cycle
    override func viewDidLoad() {
        
        self.setupObservers()
        self.getData()
        super.viewDidLoad()
        self.tableview.delegate = self
        self.tableview.dataSource = self
        self.searchView.delegate = self
        self.tableview.register(UINib(nibName: "NewsTableViewCell", bundle: nil), forCellReuseIdentifier: "NewsTableViewCell")
        self.setupViewModel()
        viewModel.getNews()
       
    }
    private func setupViewModel()
    {
        self.viewModel = ViewModel(view: self)
    }
    
    
    private func getData(){
        let params : [String:Any] = [
            "apiKey": self.apiKey,
            "q": "apple",
            "from": "2022-07-17",
            "to": "2022-07-17",
            "sortBy": "popularity"
        ]
        self.fetchNewsAction.apply(params).start()
    }
    
    private let fetchNewsAction = Action {(params:[String:Any]) -> SignalProducer<[Article], ModelError> in
        return Article.fetch(params: params)
    }
    private func setupObservers() {

        self.disposable += self.fetchNewsAction.values.observeValues({ [weak self] (articals) in
            self?.filtersArticals = articals
           print(articals.count, "Articals")
            DispatchQueue.main.async {
                self?.tableview.reloadData()
            }
        })
        
        self.disposable += self.fetchNewsAction.errors.observeValues({ [weak self] (error) in
            print(error)
        })
    }

}


extension ViewController : UITableViewDelegate, UITableViewDataSource  {
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.viewModel.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.numberOfItems(at: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let identifier = self.reuseIdentifier(at: indexPath),
            let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? TableViewCell else {
                return UITableViewCell()
        }
        cell.delegate = self
        cell.item = self.viewModel?.item(at: indexPath)
        cell.selectionStyle = .none
        return cell
    }
    
    
    private func reuseIdentifier(at indexPath: IndexPath) -> String? {
        let item = self.viewModel?.item(at: indexPath)
        switch item {
        case _ as NewsTableViewCellModel:
            return NewsTableViewCell.reuseIdentifier
        default: return nil
        }
    }

    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
        
    }
    
   
//   // create vc object
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let nextVc = DescViewController(nibName: "DescViewController", bundle: nil)
        nextVc.articel = self.filtersArticals?[indexPath.row]
        self.navigationController?.pushViewController(nextVc, animated: true)
    }

}
extension ViewController : UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text , !text.isEmpty else{
            return
        }
        let params : [String: Any] = [
            "apikey" : self.apiKey,
            "q" : text,
            "sortBy" : "popularity"
        ]
        self.fetchNewsAction.apply(params).start()
    }
}


extension ViewController : ViewModelDelegate {
    func reload() {
        self.tableview.reloadData()
    }
    
    
    
}
extension UIView: StaticReuseIdentifierProvider {
    static var reuseIdentifier: String { return String(describing: self).components(separatedBy: ".").last! }
}
