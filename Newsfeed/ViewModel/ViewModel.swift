//
//  ViewModel.swift
//  Newsfeed
//
//  Created by riya singhal on 21/07/22.
//

import Foundation
import ReactiveSwift


class NewsTableViewCellModel {
    var article: Article
    init(article: Article) {
        self.article = article
        
    }
}


class SectionModels {
    var headerModel: Any?
    var cellModels: [Any] = []
    var footerModel: Any?
    
    
    
    init(headerModel: Any? = nil,
         cellModels: [Any] = [],
         footerModel: Any? = nil) {
        
        self.headerModel = headerModel
        self.footerModel = footerModel
        self.cellModels = cellModels
        
        
    }
    
    
}





protocol ViewModelDelegate : AnyObject {
    func reload()
}
class ViewModel {
    let apiKey = "89b889f4e7ca4dce818f9436f30aa34f"
    
    var loading = MutableProperty<Bool>(false)
    var disposable = CompositeDisposable([])
    var sectionModels = MutableProperty<[SectionModels]>([])
    var cellModels = MutableProperty<[Any]>([])
    var articals:[Article] = []
    weak var view : ViewModelDelegate?
    
    init(view: ViewModelDelegate) {
        self.view = view
        self.setupObservers()
        
    }
    private let fetchNewsAction = Action {(params:[String:Any]) -> SignalProducer<[Article], ModelError> in
        return Article.fetch(params: params)
    }
    private func setupObservers() {

        self.disposable += self.fetchNewsAction.values.observeValues({ [weak self] (articals) in
            self?.articals = articals
            self?.prepareCellModel()
           print(articals.count, "Articals")
          
        })
        
        self.disposable += self.fetchNewsAction.errors.observeValues({ [weak self] (error) in
            print(error)
        })
    }
    
    private func prepareCellModel() {
        self.sectionModels.value = []
        self.cellModels.value = []
        for article in self.articals {
            self.cellModels.value.append(NewsTableViewCellModel(article: article))
            
        }
        
        self.sectionModels.value = [SectionModels(headerModel: nil, cellModels: cellModels.value, footerModel: nil)]
        self.view?.reload()
    }

}


extension ViewModel : ViewControllerDelegate {
    var numberOfSections: Int {
        return self.sectionModels.value.count
        
    }
    func numberOfItems(at section: Int) -> Int {
        return self.sectionModels.value[section].cellModels.count
    }
    func item(at indexPath: IndexPath) -> Any {
        return self.sectionModels.value[indexPath.section].cellModels[indexPath.item]
        
    }
    func getNews() {
        let params : [String:Any] = [
            "apiKey": self.apiKey,
            "q": "apple",
            "from": "2022-07-17",
            "to": "2022-07-17",
            "sortBy": "popularity"
        ]
        self.fetchNewsAction.apply(params).start()
    }
    
    
    
}


