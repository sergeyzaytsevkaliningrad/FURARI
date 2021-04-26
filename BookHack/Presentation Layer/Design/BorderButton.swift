//
//  BorderButton.swift
//  Pokushats
//
//  Created by Yoav Nemirovsky on 02.12.2020.
//  Copyright © 2020 Yoav. All rights reserved.
//

import UIKit

final class BorderButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        layer.borderColor = AppColors.white.cgColor
        layer.borderWidth = 1.0
        layer.cornerRadius = 6
        titleLabel?.numberOfLines = 0
        setTitleColor(AppColors.white, for: .normal)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

