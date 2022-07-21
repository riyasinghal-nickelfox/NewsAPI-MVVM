//
//  DescViewController.swift
//  Newsfeed
//
//  Created by riya singhal on 30/06/22.
//

import UIKit

class DescViewController: UIViewController {
    
    var articel:Article?
    @IBOutlet weak var newsImage : UIImageView!
    @IBOutlet weak var myName : UILabel!
    @IBOutlet weak var myDescription : UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.myName.text = articel?.title
        self.myDescription.text = articel?.description
        self.newsImage.layer.cornerRadius = 16
        if let imageUrl = URL(string: articel?.urlToImage ?? "") {
            self.downloadImage(from: imageUrl)
        }
        
    }
    
    func downloadImage(from url: URL) {
        print("Download Started")
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            
            // it always update the UI from the main thread
            DispatchQueue.main.async() { [weak self] in
                self?.newsImage.image = UIImage(data: data)
            }
        }
    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
}
