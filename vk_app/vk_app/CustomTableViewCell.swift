//
//  CustomTableViewCell.swift
//  vk_app
//
//  Created by Matvey Garbuzov on 15.07.2022.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    static let identifier = "CustomTableViewCell"
    
    private let appImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .main
        label.font = .systemFont(ofSize: 16, weight: .bold)
        
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondary
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.numberOfLines = 0
        
        return label
    }()
    
    private let linkLabel: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "arrow.forward")
        
        return imageView
    }()
    
    private var link: String = ""

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(appImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(linkLabel)
    }
    
    func configure(text: String, description: String, link: String, icon_url: String) {
        self.nameLabel.text = text
        self.descriptionLabel.text = description
        self.link = link
        self.appImageView.loadFrom(URLAddress: icon_url)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        let imageSize = contentView.frame.size.height - 5
        
        appImageView.frame = CGRect(
            x: 10,
            y: 5,
            width: imageSize,
            height: imageSize)
        
        nameLabel.frame = CGRect(
            x: 20 + appImageView.frame.size.width,
            y: 5,
            width: contentView.frame.size.width - 30 - appImageView.frame.size.width - 30,
            height: contentView.frame.size.height / 4 // (1/4 of cell's height)
        )
        
        descriptionLabel.frame = CGRect(
            x: 20 + appImageView.frame.size.width,
            y: nameLabel.frame.size.height + 5,
            width: contentView.frame.size.width - 30 - appImageView.frame.size.width - 30,
            height: contentView.frame.size.height / 4 * 3 - 5 // (3/4 of cell's height)
        )
        
        linkLabel.frame = CGRect(
            x: 5 + nameLabel.frame.size.width + 20 + appImageView.frame.size.width,
            y: nameLabel.frame.size.height + 5,
            width: 20,
            height: 15
        )
    }
}

// Extension for loading Image from URL
extension UIImageView {
    func loadFrom(URLAddress: String) {
        guard let url = URL(string: URLAddress) else {
            return
        }
        
        DispatchQueue.main.async { [weak self] in
            if let imageData = try? Data(contentsOf: url) {
                if let loadedImage = UIImage(data: imageData) {
                        self?.image = loadedImage
                }
            }
        }
    }
}
