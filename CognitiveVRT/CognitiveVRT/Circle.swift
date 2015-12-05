//
//  Circle.swift
//  CognitiveVRT
//
//  Created by Oliver Nielsen on 04/12/15.
//  Copyright © 2015 Oliver Nielsen. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class Circle: UIView {
    
    var button: UIButton = {
        var tempButton = UIButton(type: UIButtonType.Custom)
        tempButton.backgroundColor = UIColor.clearColor()
        
        return tempButton
    }()
    
    
    private var diameter: CGFloat
    
    override init(frame : CGRect) {
        self.diameter = frame.height;
        
        super.init(frame : frame)
    }
    
    init(diameter: CGFloat, color: UIColor) {
        self.diameter = diameter
        
        super.init(frame: CGRectMake(0, 0, diameter, diameter))
        
        
        self.backgroundColor = color
        self.layer.cornerRadius = diameter / 2
        
        self.button.layer.cornerRadius = self.layer.cornerRadius

        self.setupSubviews()
        self.setupConstraints()
    }

    private func setupSubviews() {
        self.addSubview(self.button)
    }
    
    private func setupConstraints() {
        self.snp_makeConstraints { (make) -> Void in
            make.height.width.equalTo(self.diameter)
        }
        
        self.button.snp_makeConstraints { (make) -> Void in
            make.width.height.equalTo(self)
        }
    }
    
    
    required init?(coder aDecoder: NSCoder) {fatalError("init(coder:) has not been implemented")}
    
}