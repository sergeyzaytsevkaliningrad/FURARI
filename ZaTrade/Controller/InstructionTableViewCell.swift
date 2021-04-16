//
//  InstructionTableViewCell.swift
//  FURARI
//
//  Created by Rudolf Oganesyan on 13.02.2021.
//

import UIKit

protocol ConvenientCell {
    
}

extension ConvenientCell {
    
    static var nib: UINib {
        return UINib(nibName: reuseIdentifier, bundle: nil)
    }
    
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

class InstructionTableViewCell: UITableViewCell, ConvenientCell {
    
    @IBOutlet private weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    
    func configureWith(title: String) {
        titleLabel.text = title
    }
}
