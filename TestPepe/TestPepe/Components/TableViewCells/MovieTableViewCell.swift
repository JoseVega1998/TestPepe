//
//  MovieTableViewCell.swift
//  TestPepe
//
//  Created by José De Jesús Vega López on 04/11/24.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    
    static let id = "MovieTableViewCell"
    
    private let banner: UIImageView = {
        let image = UIImageView()
        image.setWidth(width: 120)
        image.setHeight(height: 100)
        return image
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .bodyFont(type: .Bold)
        label.textColor = .primary
        label.numberOfLines = 2
        return label
    }()
    
    private let releasedDateLabel: UILabel = {
        let label = UILabel()
        label.font = .bodySFont(type: .Medium)
        label.textColor = .primary
        label.numberOfLines = 1
        return label
    }()
    
    private let voteAverageLabel: UILabel = {
        let label = UILabel()
        label.font = .bodyXsFont(type: .Medium)
        label.textColor = .primary
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var contentStack: UIStackView = {
        let starIcon = UIImage(systemName: "star.fill") ?? .checkmark
        starIcon.withRenderingMode(.alwaysTemplate)
        let star = UIImageView(image: starIcon)
        star.tintColor = .systemYellow
        star.setSquareView(with: 10)
        
        let averageStack = UIStackView(arrangedSubviews: [
            star,
            self.voteAverageLabel
        ])
        averageStack.axis = .horizontal
        averageStack.distribution = .fill
        
        let verticalStack = UIStackView(arrangedSubviews: [
            self.titleLabel,
            self.releasedDateLabel,
            averageStack
        ])
        verticalStack.axis = .vertical
        verticalStack.distribution = .fill
        verticalStack.alignment = .leading
        
        self.titleLabel.setConstraints(
            left: verticalStack.leftAnchor,
            right: verticalStack.rightAnchor,
            paddingRight: 8
        )
        self.releasedDateLabel.setConstraints(
            left: verticalStack.leftAnchor,
            right: verticalStack.rightAnchor,
            paddingRight: 8
        )

        let chevronIcon = UIImage(systemName: "info.circle") ?? .checkmark
        chevronIcon.withRenderingMode(.alwaysTemplate)
        let chevron = UIImageView(image: chevronIcon)
        chevron.tintColor = UIColor.primary
        chevron.setSquareView(with: 20)

        let horizontalStack = UIStackView(arrangedSubviews: [
            self.banner,
            verticalStack,
            chevron
        ])
        horizontalStack.axis = .horizontal
        horizontalStack.spacing = 0
        horizontalStack.distribution = .fill
        horizontalStack.alignment = .center
        return horizontalStack
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUpUi()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpUi()  {
        self.backgroundColor = .clear
        self.addSubview(self.contentStack)
        self.contentStack.setConstraints(
            top: self.topAnchor,
            paddingTop: 16,
            bottom: self.bottomAnchor,
            paddingBottom: 16,
            left: self.leftAnchor,
            paddingLeft: 16,
            right: self.rightAnchor,
            paddingRight: 16
        )
    }
    
    public func configData(
        banner: String,
        title: String,
        releaseDate: String,
        voteAverage: Double,
        voteCount: Int
    ){
        self.titleLabel.text = title
        self.releasedDateLabel.text = releaseDate
        self.voteAverageLabel.text = "\(voteAverage.rounded(toPlaces: 1)) (\(voteCount))"
        self.banner.downloadImage(from: "https://image.tmdb.org/t/p/original\(banner)")
    }
}

extension Double {
    /// Rounds the double to decimal places value
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
