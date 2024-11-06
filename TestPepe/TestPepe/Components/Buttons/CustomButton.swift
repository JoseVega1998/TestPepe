//
//  CustomButton.swift
//  TestPepe
//
//  Created by José De Jesús Vega López on 02/11/24.
//

import UIKit

class CustomButton: BaseButton {
    // MARK: - PRIVATE PROPERTIES
    private var performs:(() -> Void)?
    
    // MARK: - PUBLIC FUNCTIONS
    public func setUp(type: BaseButtonType, title: String = "") {
        var model: ButtonModel = type.model
        model.title = title
        super.setUpUI(model: model)
    }
                
    public func setAction(performs: @escaping (() -> Void)) {
        self.performs = performs
        self.addTarget(self, action: #selector(onTouchUpInside), for: .touchUpInside)
    }
    
    // MARK: - PRIVATE FUNCTIONS
    @objc private func onTouchUpInside() {
        guard let performs = self.performs else { fatalError("Performs is nil") }
        performs()
    }
}
