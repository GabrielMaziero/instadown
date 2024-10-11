//
//  ViewController.swift
//  instadown
//
//  Created by GABRIEL CHAVES MAZIERO on 29/06/23.
//

import UIKit
import AVFoundation
import AVKit

class ViewController: UIViewController {
    
    private var player: AVPlayer!
    private var playerController = AVPlayerViewController()
    
    private lazy var videoView: UIView = {
        let view = UIView(frame: .zero)
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.backgroundColor = .black
        
        return view
    }()

    
    
    private lazy var urlTextField: UITextField = {
        let urlView = UITextField(frame: .zero)
        
        urlView.translatesAutoresizingMaskIntoConstraints = false
        
        urlView.layer.cornerRadius = 6.0
        
        urlView.layer.maskedCorners = [.layerMinXMaxYCorner,.layerMinXMinYCorner]
        
        urlView.keyboardType = .URL
        urlView.autocapitalizationType = .none
        urlView.backgroundColor = .systemGray6
        urlView.attributedPlaceholder = NSAttributedString(string:"cole o link aqui!", attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "Placeholder") ?? .gray])
        
        
        urlView.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: urlView.frame.height))
        urlView.leftViewMode = .always
        urlView.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: urlView.frame.height))
        urlView.rightViewMode = .always
        
        
        return urlView
    }()
    
    private lazy var copyButton: UIButton = {
        let button = UIButton(frame: .zero)
        
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.setImage(UIImage(systemName: "clipboard"), for: .normal)
        button.tintColor = .black
        button.backgroundColor = .systemGray2
        button.layer.cornerRadius = 6.0
        button.layer.maskedCorners = [.layerMaxXMaxYCorner,.layerMaxXMinYCorner]
        
        return button
    }()
    
    private lazy var DownloadButton: UIButton = {
        let button = UIButton(frame: .zero)
        
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.setTitle("Download", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .black
        button.layer.cornerRadius = 6.0
        
        return button
    }()
    
    func setUpPlayer() {
        playerController.view.frame = videoView.frame
        playerController.videoGravity = .resizeAspect
        self.addChild(playerController)
        self.videoView.addSubview(playerController.view)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupView()
        setUpPlayer()
    }
    
    private func playVideo(from url: URL){
        let playerItem = AVPlayerItem(url: url)
        player = AVPlayer(playerItem: playerItem)
        playerController.player = player
//        player.play()
    }
    
    //MARK: - actions
    
    @objc func actionCopyButton(sender: UIButton!) {
        urlTextField.text = ""
        if let myString = UIPasteboard.general.string {
            urlTextField.insertText(myString)
        }
    }
    
    @objc func actionDownloadButton(){
        guard let urlString = urlTextField.text, let url = URL(string: urlString) else {
            return
        }
        playVideo(from: url)
    }
    
    
    //MARK: - constraints
    
    private func constraintsVideoView(){
        NSLayoutConstraint.activate([
            videoView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            videoView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.3),
            videoView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            videoView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            videoView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
        ])
    }
    
    private func constraintsUrlTextField(){
        NSLayoutConstraint.activate([
            urlTextField.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            urlTextField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor,constant: 20),
            urlTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor,constant: -80),
            urlTextField.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    private func constraintsbuttonCopyButton(){
        NSLayoutConstraint.activate([
            copyButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            copyButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor,constant: -20),
            copyButton.leadingAnchor.constraint(equalTo: urlTextField.trailingAnchor),
            copyButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    private func constraintsDownloadButton(){
        NSLayoutConstraint.activate([
            DownloadButton.topAnchor.constraint(equalTo: urlTextField.bottomAnchor,constant: 20),
            DownloadButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor,constant: 20),
            DownloadButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor,constant: -20),
            DownloadButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
}

extension ViewController: CodeView {
    func addSubViews() {
        view.addSubview(videoView)
        view.addSubview(urlTextField)
        view.addSubview(copyButton)
        view.addSubview(DownloadButton)
    }
    
    func configContraints() {
        constraintsVideoView()
        constraintsUrlTextField()
        constraintsbuttonCopyButton()
        constraintsDownloadButton()
    }
    
    func setupAdditionalConfiguration() {
        view.backgroundColor = .white
        
        copyButton.addTarget(self, action: #selector(actionCopyButton), for: .touchUpInside)
        DownloadButton.addTarget(self, action: #selector(actionDownloadButton), for: .touchUpInside)
    }
}
