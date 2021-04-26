//
//  GiveTakeButton.swift
//  BookHack
//
//  Created by Yoav Nemirovsky on 20.03.2021.
//

import UIKit

final class GiveTakeButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = AppColors.systemPink
        layer.cornerRadius = 10
        setTitleColor(AppColors.white, for: .normal)
        layer.borderColor = AppColors.systemPink.cgColor
        layer.borderWidth = 1
        titleLabel?.numberOfLines = 0
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
