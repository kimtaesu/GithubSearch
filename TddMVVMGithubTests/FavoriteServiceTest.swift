//
//  FavoriteServiceTest.swift
//  TddMVVMGithubTests
//
//  Created by tskim on 2019/10/31.
//  Copyright © 2019 hucet. All rights reserved.
//
import Foundation
import XCTest
import RxSwift
import RxTest
import CoreData
import RxBlocking
@testable import TddMVVMGithub

class FavoriteServiceTest: XCTestCase {

    var service: FavoriteServiceType!
    var context: NSManagedObjectContext!

    override func setUp() {
        super.setUp()
        service = FavoriteService()
        context = CoreDataManager.shared.context
    }

    func testAddFavorite() {
        let favorite = Fixture.FXRFavorite.createFavorite(context: context, id: 1)
        let expect = [favorite]
        let actual = try! service.getFavorite(context: context).toBlocking().single()
        XCTAssertEqual(expect, actual)
    }
    
    func testIsFavorite() {
        Fixture.FXRFavorite.createFavorite(context: context, id: 1)
        let actualTrue = try! service.isFavorite(context: context, id: 1).toBlocking().single()
        XCTAssertEqual(true, actualTrue)
        
        let actualFalse = try! service.isFavorite(context: context, id: 2).toBlocking().single()
        XCTAssertEqual(false, actualFalse)
    }
}
