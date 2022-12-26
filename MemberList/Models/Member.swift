//
//  Member.swift
//  MemberList
//
//  Created by 혜리 on 2022/12/05.
//

import UIKit

// AnyObject는 class에서만 채택을 할 수 있게 해줌
protocol MemberDelegate: AnyObject {
    func addNewMember(_ member: Member)
    func update(index: Int, _ member: Member)
}

// 데이터 묶음은 struct
struct Member {
    
    lazy var memberImage: UIImage? = {
        // 이름이 없다면 시스템 사람 이미지 세팅
        guard let name = name else {
            return UIImage(systemName: "person")
        }
        // 해당 이름으로 된 이미지가 없다면 시스템 사람 이미지 세팅
        return UIImage(named: "\(name).png") ?? UIImage(systemName: "person")
    }()
    
    // 멤버의 (절대적) 순서를 위한 타입 저장 속성
    static var memberNumbers: Int = 0
    
    let memberId: Int
    var name: String?
    var age: Int?
    var phone: String?
    var address: String?
    
    // 생성자 구현
    init(name: String?, age: Int?, phone: String?, address: String?) {
        
        // 0일 때는 0, 0이 아닐 때는 타입저장속성의 절대적 값으로 세팅 (자동 순번)
        self.memberId = Member.memberNumbers
        
        // 나머지 저장 속성은 외부에서 세팅
        self.name = name
        self.age = age
        self.phone = phone
        self.address = address
        
        // 멤버를 생성한다면, 항상 타입 저장 속성의 정수값 + 1
        Member.memberNumbers += 1
    }
}
