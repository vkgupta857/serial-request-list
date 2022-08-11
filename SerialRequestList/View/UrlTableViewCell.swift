//
//  UrlTableViewCell.swift
//  SerialRequestList
//
//  Created by 1778948 on 21/09/21.
//

import UIKit

class UrlTableViewCell: UITableViewCell {
    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var cellTitle: UILabel!
    @IBOutlet weak var cellStatus: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCellFromURL(urlString: String){
        self.cellTitle.text = urlString
    }
    
    func configureCellFromItem(item: URLItem){
        self.cellTitle.text = item.url
        self.cellImage.image = UIImage(data: item.imageData)
        self.cellStatus.text = item.status
    }
}
