//
//  CharacterTableViewCell.swift
//  RickAndMorty-Combine
//
//  Created by omaestra on 17/6/21.
//

import UIKit

class CharacterTableViewCell: UITableViewCell, Identifiable {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var characterImageView: UIImageView! {
        didSet {
            characterImageView.clipsToBounds = true
            characterImageView.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var characterName: UILabel!
    @IBOutlet weak var characterStatus: UILabel!
    @IBOutlet weak var lastKnownLocationValueLabel: UILabel!
    @IBOutlet weak var firstSeenInValueLabel: UILabel!
    
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        containerView.layer.cornerRadius = 5.0
        containerView.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(with character: Character) {
        self.characterName.text = character.name
        self.characterStatus.text = "\(character.status) - \(character.gender)"
        if let locationName = character.location.name {
            self.lastKnownLocationValueLabel.text = locationName
        }
        if let originName = character.location.name {
            self.firstSeenInValueLabel.text = originName
        }
        if let url = URL(string: character.image) {
            self.characterImageView?.load(url: url)
        }
    }
}
