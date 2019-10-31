//
//  DetailViewController.swift
//  TddMVVMGithub
//
//  Created by tskim on 2019/10/31.
//  Copyright © 2019 hucet. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, OptionMenuViewDelegate {
    private let optionMenuView = OptionMenuView()
    
    private let userAvatar: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private let user: GitUser
    
    init(user: GitUser) {
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(visibleToggleOptionMenu)))
        optionMenuView.delegate = self
        optionMenuView.snp.makeConstraints {
            self.view.addSubview(optionMenuView)
            $0.leading.top.trailing.equalToSuperview()
        }
        userAvatar.snp.makeConstraints {
            self.view.addSubview(userAvatar)
            let width = 80
            $0.width.equalTo(width)
            $0.height.equalTo(width)
            $0.center.equalToSuperview()
        }
        userAvatar.beautiful.setImage(with: URL(string: self.user.avatar_url))
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        optionMenuView.resetTimer()
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        optionMenuView.cancelTimer()
    }
    @objc
    func visibleToggleOptionMenu() {
      self.optionMenuView.visibleToggle()
    }
    func optionMenu(close: Bool) {
        self.dismiss(animated: true)
    }
}
