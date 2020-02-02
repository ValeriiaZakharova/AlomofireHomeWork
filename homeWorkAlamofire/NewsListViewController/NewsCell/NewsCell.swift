//
//  NewsCell.swift
//  homeWorkAlamofire
//
//  Created by Valeriia Zakharova on 26.01.2020.
//  Copyright © 2020 Valeriia Zakharova. All rights reserved.
//

import UIKit

protocol NewsCellDelegate {
    func didTapToggle(cell: NewsCell)
}

class NewsCell: UITableViewCell {
    
    @IBOutlet weak var pictureImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var seeMoreButton: UIButton!
    
    @IBOutlet var descriptionHeighConst: NSLayoutConstraint!
    
    var delegate: NewsCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    
    @IBAction func didTapToggle(_ sender: Any) {
        delegate?.didTapToggle(cell: self)
        
    }
}

extension NewsCell {
    
    func updateCell(model: NewsArticleModel, isExpanded: Bool) {
       
        if let urlString = model.urlToImage, let url = URL(string: urlString) {
            DispatchQueue.global().async {
                do {
                    let data = try Data(contentsOf: url)
                    let image = UIImage(data: data)
                    DispatchQueue.main.async {
                        self.pictureImageView.image = image
                        self.setNeedsLayout()
                    }
                } catch {
                    print(error)
                }
            }
        }
        
        if let title = model.title {
            titleLabel.text = title
        }
        if let date = model.publishedAt {
            dateLabel.text = date
        }
        if let description = model.description {
            descriptionLabel.text = description
        }
        if isExpanded {
            descriptionHeighConst.isActive = false
            seeMoreButton.isSelected = true
        } else {
            descriptionHeighConst.isActive = true
            seeMoreButton.isSelected = false
        }
    }
}
