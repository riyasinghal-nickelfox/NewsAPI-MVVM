//
//  NewsTableViewCell.swift
//  Newsfeed
//
//  Created by riya singhal on 27/06/22.
//

import UIKit

class NewsTableViewCell: TableViewCell {
    @IBOutlet weak var newsImage : UIImageView!
    @IBOutlet weak var newsTitle : UILabel!
    @IBOutlet weak var newsDescription : UILabel!
    
    
    override func awakeFromNib()
    {
        
        super.awakeFromNib()
        self.newsImage.layer.cornerRadius = 16
    }
    
    override func configure(_ item: Any?) {
        if let item = item as? NewsTableViewCellModel {
            self.newsTitle.text = item.article.title
            self.newsDescription.text = item.article.description
             
            if let url = URL(string: item.article.urlToImage ?? "") {
                self.downloadImage(from: url)
            }
            
            
        }
    }
    
    func downloadImage(from url: URL) {
        print("Download Started")
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            
            // always update the UI from the main thread
            DispatchQueue.main.async() { [weak self] in
                self?.newsImage.image = UIImage(data: data)
            }
        }
    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
}
