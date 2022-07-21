//
//  TableViewCell.swift
//  Newsfeed
//
//  Created by riya singhal on 21/07/22.
//

import UIKit

class TableViewCell: UITableViewCell {

    var item: Any? {
        didSet {
            self.configure(self.item)
        }
    }

    weak var delegate: NSObjectProtocol?

    func configure(_ item: Any?) {

    }

}


class TableHeaderFooterView: UITableViewHeaderFooterView {

    var item: Any? {
        didSet {
            self.configure(self.item)
        }
    }

    weak var delegate: NSObjectProtocol?

    func configure(_ item: Any?) {

    }
    
}
