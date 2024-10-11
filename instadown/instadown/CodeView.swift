//
//  CodeView.swift
//  instadown
//
//  Created by GABRIEL CHAVES MAZIERO on 29/06/23.
//

protocol CodeView {
    func addSubViews()
    func configContraints()
    func setupAdditionalConfiguration()
    func setupView()
}

extension CodeView {
    func setupView() {
        addSubViews()
        configContraints()
        setupAdditionalConfiguration()
    }
}
