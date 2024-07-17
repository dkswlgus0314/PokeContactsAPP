//
//  PhoneBookTableViewCell.swift
//  PokeContacts
//
//  Created by ahnzihyeon on 7/16/24.
//

import UIKit
import SnapKit

class PhonBookTableViewCell: UITableViewCell {
    
    //프로필 이미지
    private var image: UIImageView = {
        let image = UIImageView()
        image.layer.borderColor = UIColor.gray.cgColor
        image.contentMode = .scaleAspectFit
        image.layer.borderWidth = 1
        image.layer.cornerRadius = 30
        return image
    }()
    
    //프로필 이름
    private var name: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "피카츄"
        return label
    }()
    
    //전화번호
    private var phoneNumber: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "010-0000-0000"
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    private func configureUI(){
        
        [image, name, phoneNumber].forEach{ self.addSubview($0) }
        
        image.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20)
            $0.width.height.equalTo(60)
            $0.centerY.equalToSuperview()
        }
        name.snp.makeConstraints {
            $0.leading.equalTo(image.snp.trailing).offset(15)
            $0.centerY.equalToSuperview()
        }
        phoneNumber.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(25)
            $0.centerY.equalToSuperview()
        }
    }
    
}
