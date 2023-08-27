//
//  DetailViewController.swift
//  TMDBProject
//
//  Created by LOUIE MAC on 2023/08/15.
//

import UIKit
import Kingfisher

class DetailViewController: UIViewController {
    
    let networkmanager = NetworkManager.shared
    var movie: Movie?
    var recommand: [Recommand] = []
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var backdropImageView: UIImageView!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var descriptionTV: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.tintColor = .black
        collectionView.dataSource = self
        setupUI()
        registerNib()
        configureCVCell()
    }
    
    private func setupUI() {
        backdropImageView.contentMode = .scaleAspectFill
        backdropImageView.alpha = 0.7
        titleLabel.font = .boldSystemFont(ofSize: 25)
        titleLabel.numberOfLines = 0
        rateLabel.font = .boldSystemFont(ofSize: 22)
        descriptionTV.font = .systemFont(ofSize: 17)
        descriptionTV.textAlignment = .left
        descriptionTV.isEditable = false
    }
    
    private func registerNib() {
        let nib = UINib(nibName: RecommandCollectionViewCell.identifier, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: RecommandCollectionViewCell.identifier)
    }
    
    private func configureCVCell() {
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 10
        let width = UIScreen.main.bounds.width - spacing
        let height = UIScreen.main.bounds.height
        layout.itemSize = CGSize(width: width/1.8, height: height/5)
        layout.sectionInset = UIEdgeInsets(top: 0, left: spacing*2, bottom: 0, right: spacing*2)
        layout.minimumInteritemSpacing = spacing
        layout.scrollDirection = .horizontal
        collectionView.collectionViewLayout = layout
        collectionView.showsHorizontalScrollIndicator = false
    }
    
    public func setupDetails(item: Movie) {
        DispatchQueue.global().async { [weak self] in
            guard let backdropURL = URL.getMovieImage(for: item.backdropPath),
                  let posterURL = URL.getMovieImage(for: item.posterPath) else {
                return
            }
            DispatchQueue.main.async {
                self?.backdropImageView.kf.setImage(with: backdropURL)
                self?.posterImageView.kf.setImage(with: posterURL)
                self?.titleLabel.text = item.title
                self?.rateLabel.text = String(item.voteAverage)
                self?.descriptionTV.text = item.overview
            }
        }
        
        DispatchQueue.global().async { [weak self] in
            self?.networkmanager.fetchRecommandData(id: item.id) { [weak self] data in
                self?.recommand = data.results
                DispatchQueue.main.async {
                    self?.collectionView.reloadData()
                }
            }
        }
    }
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}

extension DetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recommand.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecommandCollectionViewCell.identifier, for: indexPath) as? RecommandCollectionViewCell else { return UICollectionViewCell() }
        let indexPath = recommand[indexPath.item]
        cell.configureCell(item: indexPath)
        return cell
    }
}
