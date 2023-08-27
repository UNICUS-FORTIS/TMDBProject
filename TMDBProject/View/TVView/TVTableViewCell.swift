//
//  TVTableViewCell.swift
//  TMDBProject
//
//  Created by LOUIE MAC on 2023/08/21.
//

import UIKit

class TVTableViewCell: UITableViewCell {

    @IBOutlet weak var backDropImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func cellConfigureForPopular(item: PopularTV) {
        DispatchQueue.main.async {
            let backDropUrl = URL.createRecommandationIMG(for: item.backdropPath ?? "")
            self.backDropImageView.kf.setImage(with: backDropUrl)
            self.titleLabel.text = item.name
            self.titleLabel.font = .boldSystemFont(ofSize: 25)
            self.titleLabel.numberOfLines = 0
            self.titleLabel.backgroundColor = .init(white: 1, alpha: 0.7)
            self.backDropImageView.contentMode = .scaleAspectFill
            // MARK: - 모서리가 이상하게 깎임.
            //            self.posterImageView.layer.cornerRadius = self.posterImageView.frame.width/6
            //            self.posterImageView.clipsToBounds = true
        }
    }
    
    func cellConfigureForTopRated(item: TVTopRated) {
        DispatchQueue.main.async {
            let backDropUrl = URL.createRecommandationIMG(for: item.backdropPath)
            self.backDropImageView.kf.setImage(with: backDropUrl)
            self.titleLabel.text = item.name
            self.titleLabel.font = .boldSystemFont(ofSize: 25)
            self.titleLabel.numberOfLines = 0
            self.titleLabel.backgroundColor = .init(white: 1, alpha: 0.7)
            self.backDropImageView.contentMode = .scaleAspectFill
            // MARK: - 모서리가 이상하게 깎임.
            //            self.posterImageView.layer.cornerRadius = self.posterImageView.frame.width/6
            //            self.posterImageView.clipsToBounds = true
        }
    }
    
    
    
}
