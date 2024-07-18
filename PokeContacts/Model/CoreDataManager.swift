//
//  CoreDataManager.swift
//  PokeContacts
//
//  Created by ahnzihyeon on 7/18/24.
//


import UIKit
import CoreData

class CoreDataManager {
    var container: NSPersistentContainer!
    var phoneBookView = PhoneBookView()
    
    init(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.container = appDelegate.persistentContainer
    }
    
    //MARK: -[Create] 코어데이터에 데이터 생성
    func createData(name: String, phoneNumber: String, image: UIImage) {
        guard let entity = NSEntityDescription.entity(forEntityName: PhoneBook.className, in: self.container.viewContext) else { return }
        guard let img = image.pngData() else { return } //이미지에서 data 타입으로 바꾸기
        let newPhoneBook = NSManagedObject(entity: entity, insertInto: self.container.viewContext)
        newPhoneBook.setValue(name, forKey: PhoneBook.Key.name)
        newPhoneBook.setValue(phoneNumber, forKey: PhoneBook.Key.phoneNumber)
        newPhoneBook.setValue(img, forKey: PhoneBook.Key.image)
        
        do {
            try self.container.viewContext.save()
            print("문맥 저장 성공")
        } catch {
            print("문맥 저장 실패")
        }
    }
    
    //MARK: -[Read] 코어데이터에 저장된 데이터 모두 읽기
    func readAllData() -> [PhoneBook]? {
        //사용자에게 입력받은 데이터를 저장할 배열
//        var phoneBookList: [PhoneBook] = []
        
//        do {
            let phoneBooks = try? self.container.viewContext.fetch(PhoneBook.fetchRequest())
            return phoneBooks
//            for phoneBook in phoneBooks as [NSManagedObject] {
//                // phoneNumber나 image의 타입이 Any로 간주되어 String 타입으로 변환할 수 없어 타입 캐스팅
//                if let name = phoneBook.value(forKey: PhoneBook.Key.name) as? String,
//                   let phoneNumber = phoneBook.value(forKey: PhoneBook.Key.phoneNumber) as? String,
//                   let image = phoneBook.value(forKey: PhoneBook.Key.image) as? Data {
//                    print("name: \(name), phoneNumber: \(phoneNumber), image: \(image)")
//                    
//                    // PhoneBook 객체를 만들어 배열에 추가
//                    let newPhoneBook = PhoneBook(context: self.container.viewContext)
//                    newPhoneBook.name = name
//                    newPhoneBook.phoneNumber = phoneNumber
//                    newPhoneBook.image = image
//                    phoneBookList.append(newPhoneBook)
//                    
//                }
//            }
//        } catch {
//            print("데이터 읽기 실패")
//        }
//        return phoneBookList
//        print("반환값 테스트 : \(phoneBookList)")
    }
    
}
