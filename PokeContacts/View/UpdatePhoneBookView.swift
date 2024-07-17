//
//  UpdatePhoneBookView.swift
//  PokeContacts
//
//  Created by ahnzihyeon on 7/16/24.
//

import UIKit
import SnapKit

class UpdatePhoneBookView: UIView {
    
    private var profileImage: UIImageView = {
        let image = UIImageView()
        image.layer.borderColor = UIColor.systemGray4.cgColor
        image.contentMode = .scaleAspectFit
        image.layer.borderWidth = 1
        image.layer.cornerRadius = 100
        return image
    }()
    private let addImageButton: UIButton = {
        let button = UIButton()
        button.setTitle("랜덤 이미지 생성", for: .normal)
        button.backgroundColor = .systemGray5
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 20
        return button
    }()
    private var inputName: UITextView = {
        let textView = UITextView()
        textView.text = "이름"
        textView.font = .systemFont(ofSize: 16)
        textView.textColor = .systemGray4
        textView.backgroundColor = .white
        
        // 테두리 설정
        textView.layer.borderColor = UIColor.systemGray4.cgColor
        textView.layer.borderWidth = 1.0
        textView.layer.cornerRadius = 8.0
        return textView
    }()
    private var inputPhoneNumber: UITextView = {
        let textView = UITextView()
        textView.text = "전화번호"
        textView.font = .systemFont(ofSize: 16)
        textView.textColor = .systemGray4
        textView.backgroundColor = .white
        
        // 테두리 설정
        textView.layer.borderColor = UIColor.systemGray4.cgColor
        textView.layer.borderWidth = 1.0
        textView.layer.cornerRadius = 8.0
        return textView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configureUI(){
        self.backgroundColor = .white
        
        [profileImage, addImageButton, inputName, inputPhoneNumber].forEach{ self.addSubview($0) }
        
        profileImage.snp.makeConstraints {
            $0.top.equalToSuperview().inset(120)
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(200)
            
        }
        addImageButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(profileImage.snp.bottom).offset(20)
            $0.height.equalTo(45)
            $0.width.equalTo(160)
            
        }
        inputName.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(addImageButton.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(10)
            $0.height.equalTo(45)
        }
        inputPhoneNumber.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(inputName.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(10)
            $0.height.equalTo(45)
        }
    }
}
