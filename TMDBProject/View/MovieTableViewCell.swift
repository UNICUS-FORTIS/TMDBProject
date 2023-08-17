//
//  MovieTableViewCell.swift
//  TMDBProject
//
//  Created by LOUIE MAC on 2023/08/12.
//

import UIKit



class MovieTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var MovieCollectionView: UICollectionView!
    
    var delegate: MoveViewControllerProtocol?
    
    var movie: [Movie]? {
        didSet {
            MovieCollectionView.reloadData()
        }
    }
    var cellCount: Int?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        MovieCollectionView.dataSource = self
        MovieCollectionView.delegate = self
        registerCVCell()
        setupCVCell()
    }
    
    private func registerCVCell() {
        let nib = UINib(nibName: MovieCollectionViewCell.identifier, bundle: nil)
        MovieCollectionView.register(nib, forCellWithReuseIdentifier: MovieCollectionViewCell.identifier)
        MovieCollectionView.backgroundColor = .clear
    }
    
    private func setupCVCell() {
        let layout = UICollectionViewFlowLayout()
        let spacing:CGFloat = 10
        // 이게 아이폰에서 디바이스 넓이를 가지고올수있는 코드
        let width = UIScreen.main.bounds.width - spacing
        let height = UIScreen.main.bounds.height
        layout.itemSize = CGSize(width: width/2.5, height: height/3)
        layout.sectionInset = UIEdgeInsets(top: 0, left: spacing*2, bottom: 0, right: spacing*2)
        // 셀의 가로간격이 안벌어짐.
        layout.minimumInteritemSpacing = spacing * 3
        //셀 세로간격
        //        layout.minimumLineSpacing = spacing
        layout.scrollDirection = .horizontal
        MovieCollectionView.collectionViewLayout = layout
        MovieCollectionView.showsHorizontalScrollIndicator = false
    }
}

extension MovieTableViewCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return movie?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = MovieCollectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.identifier, for: indexPath) as? MovieCollectionViewCell else {return UICollectionViewCell() }
        if let movie = movie?[indexPath.row] {
            cell.cellConfigure(item: movie)
        }
        return cell
    }
    
}

extension MovieTableViewCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let movieIndexPath = movie?[indexPath.item] else { return }
        delegate?.toDatailViewController(withData: movieIndexPath)
    }
}
