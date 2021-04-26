//
//  FillButton.swift
//  Pokushats
//
//  Created by Yoav Nemirovsky on 02.12.2020.
//  Copyright © 2020 Yoav. All rights reserved.
//

import UIKit

final class FillButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = AppColors.white
        layer.cornerRadius = 6
        setTitleColor(AppColors.systemGray2, for: .disabled)
        setTitleColor(AppColors.systemPink, for: .normal)
        titleLabel?.numberOfLines = 0
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

