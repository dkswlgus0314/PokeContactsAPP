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
        // AppDelegate에서 persistentContainer 가져오기
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.container = appDelegate.persistentContainer
    }
    
    //MARK: -[Create] 코어데이터에 데이터 생성
    func createData(name: String, phoneNumber: String, image: UIImage) {
        // PhoneBook 엔티티 생성
        guard let entity = NSEntityDescription.entity(forEntityName: PhoneBook.className, in: self.container.viewContext) else { return }
        // UIImage를 Data 타입으로 변환
        guard let img = image.pngData() else { return } //이미지에서 data 타입으로 바꾸기
        let newPhoneBook = NSManagedObject(entity: entity, insertInto: self.container.viewContext)
        // 엔티티 속성 설정
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
        let fetchRequest: NSFetchRequest<PhoneBook> = NSFetchRequest<PhoneBook>(entityName: "PhoneBook")
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        do {
            let phoneBooks = try self.container.viewContext.fetch(fetchRequest)
            return phoneBooks
        } catch {
            print("데이터 읽기 실패: \(error)")
            return nil
        }
    }
    
    // MARK: - [Update] 코어데이터에 저장된 데이터 수정
    func updateData(currentPhoneNumer: String, newName: String, newPhoneNumber: String, newImage: UIImage) {
        print(#function)
        // 현재 이름에 해당하는 데이터를 찾기 위한 fetch request 생성
        let fetchRequest = PhoneBook.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "phoneNumber == %@", currentPhoneNumer)
        
        do {
            // fetch request 실행
            let result = try self.container.viewContext.fetch(fetchRequest)
            
            if let phoneBook = result.first {
                // 데이터 수정
                phoneBook.name = newName
                phoneBook.phoneNumber = newPhoneNumber
                phoneBook.image = newImage.pngData()
                
                // 변경 사항 저장
                try self.container.viewContext.save()
                print("데이터 수정 완료")
            }
        } catch {
            print("데이터 수정 실패")
        }
    }
    
    // MARK: - [Delete] 코어데이터에 저장된 데이터 삭제
    func deleteData(phoneNumer: String) {
        // 삭제할 데이터를 찾기 위한 fetch request 생성
        let fetchRequest = PhoneBook.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "phoneNumber == %@", phoneNumer)
        
        do {
            // fetch request 실행
            let result = try self.container.viewContext.fetch(fetchRequest)
            
            // 결과 처리
            for data in result as [NSManagedObject] {
                // 삭제
                self.container.viewContext.delete(data)
                print("삭제된 데이터: \(data)")
            }
            
            // 변경 사항 저장
            try self.container.viewContext.save()
            print("데이터 삭제 완료")
            
        } catch {
            print("데이터 삭제 실패: \(error)")
        }
    }
    
}
