//
//  CustomButton.swift
//  TestPepe
//
//  Created by José De Jesús Vega López on 02/11/24.
//

import UIKit

@objc public class CustomButton: BaseButton {
    private var performs:(() -> Void)?
    
    public func setUp(type: BaseButtonType, title: String = "") {
        var model: ButtonModel = type.model
        model.title = title
        super.setUpUI(model: model)
    }
                
    public func setAction(performs: @escaping (() -> Void)) {
        self.performs = performs
        self.addTarget(self, action: #selector(onTouchUpInside), for: .touchUpInside)
    }
    
    @objc private func onTouchUpInside() {
        guard let performs = self.performs else { fatalError("Performs is nil") }
        performs()
    }
}
