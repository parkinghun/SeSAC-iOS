//
//  ProfileView.swift
//  MVVMBasic
//
//  Created by 박성훈 on 8/13/25.
//

import UIKit
import SnapKit

final class ProfileView: UIView {
    let profileImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.layer.borderWidth = 6
        view.layer.borderColor = Colors.btEnabledColor.cgColor
        view.layer.cornerRadius = 50
        view.clipsToBounds = true
        view.isUserInteractionEnabled = true
        return view
    }()
    let photoImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "camera.circle.fill")
        view.tintColor = Colors.btEnabledColor
        view.contentMode = .scaleAspectFill
        view.backgroundColor = .white
        view.clipsToBounds = true
        view.layer.cornerRadius = 20
        view.isUserInteractionEnabled = true
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureHierachy()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension ProfileView {
    func configureHierachy() {
        self.addSubview(profileImageView)
        self.addSubview(photoImageView)
    }
    
    func configureLayout() {
        profileImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        photoImageView.snp.makeConstraints { make in
            make.center.equalTo(profileImageView).offset(35)
            make.size.equalTo(40)
        }
    }
}
