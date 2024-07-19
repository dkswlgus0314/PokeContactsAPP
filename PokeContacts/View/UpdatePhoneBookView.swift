//
//  UpdatePhoneBookView.swift
//  PokeContacts
//
//  Created by ahnzihyeon on 7/16/24.
//

import UIKit
import SnapKit

class UpdatePhoneBookView: UIView {
    
    let updatePhoneBookViewCotroller = UpdatePhoneBookViewCotroller()
    var phoneBookViewController: PhoneBookViewController?
    
    var profileImage: UIImageView = {
        let image = UIImageView()
        image.layer.borderColor = UIColor.systemGray4.cgColor
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        image.layer.borderWidth = 1
        image.layer.cornerRadius = 100
        return image
    }()
    lazy var randomImageButton: UIButton = {
        let button = UIButton()
        button.setTitle("랜덤 이미지 생성", for: .normal)
        button.backgroundColor = .systemGray5
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 20
        return button
    }()
    var inputName: UITextView = {
        let textView = UITextView()
        textView.textColor = .systemGray4
        textView.font = .systemFont(ofSize: 16)
        textView.backgroundColor = .white
        textView.text = "이름을 입력하세요."
        textView.tag = 1
        
        // 테두리 설정
        textView.layer.borderColor = UIColor.systemGray4.cgColor
        textView.layer.borderWidth = 1.0
        textView.layer.cornerRadius = 8.0
        return textView
    }()
    var inputPhoneNumber: UITextView = {
        let textView = UITextView()
        textView.textColor = .systemGray4
        textView.font = .systemFont(ofSize: 16)
        textView.backgroundColor = .white
        textView.text = "전화번호를 입력하세요."
        textView.tag = 2
        
        // 테두리 설정
        textView.layer.borderColor = UIColor.systemGray4.cgColor
        textView.layer.borderWidth = 1.0
        textView.layer.cornerRadius = 8.0
        return textView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        
        inputName.delegate = self
        inputPhoneNumber.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configureUI(){
        self.backgroundColor = .white
        
        [profileImage, randomImageButton, inputName, inputPhoneNumber].forEach{ self.addSubview($0) }
        
        profileImage.snp.makeConstraints {
            $0.top.equalToSuperview().inset(120)
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(200)
            
        }
        randomImageButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(profileImage.snp.bottom).offset(20)
            $0.height.equalTo(45)
            $0.width.equalTo(160)
        }
        inputName.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(randomImageButton.snp.bottom).offset(20)
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


//MARK: -PlaceHolder 설정
extension UpdatePhoneBookView: UITextViewDelegate {
    
    // 아래 함수들은 UITextViewDelegate 프로토콜에 포함된 메서드들
    // 1. 사용자가 텍스트 뷰에 입력을 시작할 때 호출되는 메서드
    func textViewDidBeginEditing(_ textView: UITextView) {
        //텍스트 뷰의 현재 텍스트 색상이 플레이스홀더 텍스트 색상인지 확인
        guard textView.textColor == .systemGray4 else { return }
        //색상이 회색이라면 텍스트 뷰의 내용을 비우고, 텍스트 색상을 어두운 회색으로 변경하여 사용자가 입력할 준비
        textView.text = nil
        textView.textColor = .darkGray
    }
    
    // 2. 사용자가 텍스트 뷰에 입력을 마칠 때 호출되는 메서드
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty{
            if textView.tag == 1 {
                textView.text = "이름을 입력하세요."
            } else if textView.tag == 2 {
                textView.text = "전화번호를 입력하세요."
            }
            //플레이스홀더 텍스트의 색상을 회색으로 변경
            textView.textColor = .systemGray4
        }
    }
}
