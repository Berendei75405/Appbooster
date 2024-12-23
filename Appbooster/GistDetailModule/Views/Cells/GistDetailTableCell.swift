//
//  GistDetailTableCell.swift
//  Appbooster
//
//  Created by Novgorodcev on 22/12/2024.
//

import Foundation
import UIKit

final class GistDetailTableCell: UITableViewCell {
    
    static let identifier = "GistDetailTableCell"
    
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
    
    //MARK: - descriptionTitleLabel
    private let descriptionTitleLabel: UILabel = {
        let lab = UILabel()
        lab.translatesAutoresizingMaskIntoConstraints = false
        lab.numberOfLines = 0
        lab.textAlignment = .left
        lab.font = .boldSystemFont(ofSize: 22)
        lab.textColor = .gray
        lab.text = "Описание файла:"
        
        return lab
    }()
    
    //MARK: - descriptionLabel
    private let descriptionLabel: UILabel = {
        let lab = UILabel()
        lab.translatesAutoresizingMaskIntoConstraints = false
        lab.numberOfLines = 0
        lab.textAlignment = .left
        lab.font = .systemFont(ofSize: 20)
        return lab
    }()
    
    //MARK: - gistTextTitleLabel
    private let gistTextTitleLabel: UILabel = {
        let lab = UILabel()
        lab.translatesAutoresizingMaskIntoConstraints = false
        lab.numberOfLines = 0
        lab.textAlignment = .left
        lab.font = .boldSystemFont(ofSize: 22)
        lab.textColor = .gray
        lab.text = "Содержание файла:"
        
        return lab
    }()
    
    //MARK: - gistTextLabel
    private let gistTextLabel: UILabel = {
        let lab = UILabel()
        lab.translatesAutoresizingMaskIntoConstraints = false
        lab.numberOfLines = 0
        lab.textAlignment = .left
        lab.font = .systemFont(ofSize: 20)
        
        return lab
    }()
    
    //MARK: - createdAtTitleLabel
    let createdAtTitleLabel: UILabel = {
        let lab = UILabel()
        lab.translatesAutoresizingMaskIntoConstraints = false
        lab.numberOfLines = 0
        lab.textAlignment = .left
        lab.font = .boldSystemFont(ofSize: 22)
        lab.textColor = .gray
        lab.text = "Создан:"
        
        return lab
    }()
    
    //MARK: - createdAtLabel
    let createdAtLabel: UILabel = {
        let lab = UILabel()
        lab.translatesAutoresizingMaskIntoConstraints = false
        lab.numberOfLines = 0
        lab.textAlignment = .left
        lab.font = .systemFont(ofSize: 20)
        
        return lab
    }()
    
    //MARK: - updatedAtTitleLabel
    let updatedAtTitleLabel: UILabel = {
        let lab = UILabel()
        lab.translatesAutoresizingMaskIntoConstraints = false
        lab.numberOfLines = 0
        lab.textAlignment = .left
        lab.font = .boldSystemFont(ofSize: 22)
        lab.textColor = .gray
        lab.text = "Обновлен:"
        
        return lab
    }()
    
    //MARK: - updatedAtLabel
    let updatedAtLabel: UILabel = {
        let lab = UILabel()
        lab.translatesAutoresizingMaskIntoConstraints = false
        lab.numberOfLines = 0
        lab.textAlignment = .left
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
            mainView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
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
                constant: -8)
        ])
        
        //descriptionTitleLabel constraints
        mainView.addSubview(descriptionTitleLabel)
        NSLayoutConstraint.activate([
            descriptionTitleLabel.topAnchor.constraint(
                equalTo: titleLabel.bottomAnchor,
                constant: 8),
            descriptionTitleLabel.leadingAnchor.constraint(
                equalTo: mainView.leadingAnchor,
                constant: 8),
            descriptionTitleLabel.trailingAnchor.constraint(
                equalTo: mainView.trailingAnchor,
                constant: -8)
        ])
        
        //descriptionLabel constraints
        mainView.addSubview(descriptionLabel)
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(
                equalTo: descriptionTitleLabel.bottomAnchor,
                constant: 8),
            descriptionLabel.leadingAnchor.constraint(
                equalTo: mainView.leadingAnchor,
                constant: 8),
            descriptionLabel.trailingAnchor.constraint(
                equalTo: mainView.trailingAnchor,
                constant: -8)
        ])
        
        //gistTextTitleLabel constraints
        mainView.addSubview(gistTextTitleLabel)
        NSLayoutConstraint.activate([
            gistTextTitleLabel.topAnchor.constraint(
                equalTo: descriptionLabel.bottomAnchor,
                constant: 8),
            gistTextTitleLabel.leadingAnchor.constraint(
                equalTo: mainView.leadingAnchor,
                constant: 8),
            gistTextTitleLabel.trailingAnchor.constraint(
                equalTo: mainView.trailingAnchor,
                constant: -8)
        ])
        
        //gistTextLabel constraints
        mainView.addSubview(gistTextLabel)
        NSLayoutConstraint.activate([
            gistTextLabel.topAnchor.constraint(
                equalTo: gistTextTitleLabel.bottomAnchor,
                constant: 8),
            gistTextLabel.leadingAnchor.constraint(
                equalTo: mainView.leadingAnchor,
                constant: 8),
            gistTextLabel.trailingAnchor.constraint(
                equalTo: mainView.trailingAnchor,
                constant: -8)
        ])
        
        //createdAtTitleLabel constraints
        mainView.addSubview(createdAtTitleLabel)
        NSLayoutConstraint.activate([
            createdAtTitleLabel.topAnchor.constraint(
                equalTo: gistTextLabel.bottomAnchor,
                constant: 8),
            createdAtTitleLabel.leadingAnchor.constraint(
                equalTo: mainView.leadingAnchor,
                constant: 8),
            createdAtTitleLabel.trailingAnchor.constraint(
                equalTo: mainView.trailingAnchor,
                constant: -8)
        ])
        
        //createdAtLabel constraints
        mainView.addSubview(createdAtLabel)
        NSLayoutConstraint.activate([
            createdAtLabel.topAnchor.constraint(
                equalTo: createdAtTitleLabel.bottomAnchor,
                constant: 8),
            createdAtLabel.leadingAnchor.constraint(
                equalTo: mainView.leadingAnchor,
                constant: 8),
            createdAtLabel.trailingAnchor.constraint(
                equalTo: mainView.trailingAnchor,
                constant: -8)
        ])
        
        //updatedAtTitleLabel constraints
        mainView.addSubview(updatedAtTitleLabel)
        NSLayoutConstraint.activate([
            updatedAtTitleLabel.topAnchor.constraint(
                equalTo: createdAtLabel.bottomAnchor,
                constant: 8),
            updatedAtTitleLabel.leadingAnchor.constraint(
                equalTo: mainView.leadingAnchor,
                constant: 8),
            updatedAtTitleLabel.trailingAnchor.constraint(
                equalTo: mainView.trailingAnchor,
                constant: -8)
        ])
        
        //updatedAtLabel constraints
        mainView.addSubview(updatedAtLabel)
        NSLayoutConstraint.activate([
            updatedAtLabel.topAnchor.constraint(
                equalTo: updatedAtTitleLabel.bottomAnchor,
                constant: 8),
            updatedAtLabel.leadingAnchor.constraint(
                equalTo: mainView.leadingAnchor,
                constant: 8),
            updatedAtLabel.trailingAnchor.constraint(
                equalTo: mainView.trailingAnchor,
                constant: -8)
        ])
    }
    
    //MARK: - config
    func config(title: String,
                description: String,
                gistText: String,
                createdAt: String,
                updatedAt: String) {
        titleLabel.text = title
        descriptionLabel.text = description
        gistTextLabel.text = gistText
        createdAtLabel.text = createdAt
        updatedAtLabel.text = updatedAt
    }
}
