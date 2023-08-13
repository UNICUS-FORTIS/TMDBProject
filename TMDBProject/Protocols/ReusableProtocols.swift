//
//  Reusable.swift
//  TMDBProject
//
//  Created by LOUIE MAC on 2023/08/12.
//

import UIKit

protocol reusableViewProtocols {
    static var identifier: String { get }
}

extension UIViewController: reusableViewProtocols {
    static var identifier: String {
        return String(describing: self)
    }
}

extension UITableViewCell: reusableViewProtocols{
    static var identifier: String {
        return String(describing: self)
    }
}

extension UICollectionViewCell: reusableViewProtocols {
    static var identifier: String {
        return String(describing: self)
    }
}
