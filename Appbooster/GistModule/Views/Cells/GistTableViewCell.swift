//
//  GistTableViewCell.swift
//  Appbooster
//
//  Created by Novgorodcev on 05/12/2024.
//

import Foundation
import UIKit

final class GistTableViewCell: UITableViewCell {
    
    static let identifier = "GistTableViewCell"
    
    //MARK: - mainView
    private let mainView: UIView = {
        var view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 20
        
        return view
    }()
    
    //MARK: - titleLabel
    private let titleLabel: UILabel = {
        let lab = UILabel()
        lab.translatesAutoresizingMaskIntoConstraints = false
        lab.numberOfLines = 0
        lab.textAlignment = .center
        lab.font = .boldSystemFont(ofSize: 22)
        
        return lab
    }()
    
    //MARK: - descriptionLabel
    private let descriptionLabel: UILabel = {
        let lab = UILabel()
        lab.translatesAutoresizingMaskIntoConstraints = false
        lab.numberOfLines = 0
        lab.textAlignment = .center
        lab.font = .systemFont(ofSize: 20)
        return lab
    }()
    
    //MARK: - init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    //MARK: - required init
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - setupUI
    private func setupUI() {
        //mainView constraint
        contentView.addSubview(mainView)
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(
                equalTo: contentView.topAnchor,
                constant: 8),
            mainView.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: 8),
            mainView.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -8),
            mainView.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor,
                constant: -8)
        ])
        
        //titleLabel constraints
        mainView.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(
                equalTo: mainView.topAnchor,
                constant: 8),
            titleLabel.leadingAnchor.constraint(
                equalTo: mainView.leadingAnchor,
                constant: 8),
            titleLabel.trailingAnchor.constraint(
                equalTo: mainView.trailingAnchor,
                constant: -8),
        ])
        
        //descriptionLabel
        mainView.addSubview(descriptionLabel)
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(
                equalTo: titleLabel.bottomAnchor,
                constant: 8),
            descriptionLabel.leadingAnchor.constraint(
                equalTo: titleLabel.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(
                equalTo: titleLabel.trailingAnchor)
        ])
    }
    
    //MARK: - config
    func config(title: String,
                description: String) {
        self.titleLabel.text = title
        self.descriptionLabel.text = description
    }
}
