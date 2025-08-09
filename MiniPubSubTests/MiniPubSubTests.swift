//
//  MiniPubSubTests.swift
//  MiniPubSubTests
//
//  Created by sangmin park on 7/24/24.
//

import XCTest
@testable import MiniPubSub

final class MiniPubSubTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

//    func testExample() throws {
//        // This is an example of a functional test case.
//        // Use XCTAssert and related functions to verify your tests produce the correct results.
//        // Any test you write for XCTest can be annotated as throws and async.
//        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
//        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
//    }
//
//    func testPerformanceExample() throws {
//        // This is an example of a performance test case.
//        measure {
//            // Put the code you want to measure the time of here.
//        }
//    }
    
//    func testMessageWithPrimaryData() throws{
//        let message = Message(key: "test", data: 1)
//        
//        let encoded = message.serialize()
//        XCTAssertNotNil(encoded)
//        
//        let encodedStr = String(data:encoded!, encoding: .utf8)
//        print("encoded : " + (encodedStr ?? "nil"))
//        
//        let decodedMessage = Message(withData: encoded!)
//        XCTAssertEqual(decodedMessage.key, "test")
//        XCTAssertEqual(decodedMessage.data as? Int, 1)
//    }
//    
//    func testMessenger() throws{
//        let m1 = Messenger()
//        let m2 = Messenger()
//        
//        m1.subscribe(key: "send_m2"){ message in
//            let key = message.key ?? ""
//            let reply = message.data as? Reply
//            
//            XCTAssertEqual(key, "send_m2")
//            XCTAssertNotNil(reply)
//            XCTAssertEqual(reply!.result, 127)
//            XCTAssertEqual(reply!.resultDeco, "[127]")
//
//            print("m1 receive!! key: \(key) | data: \( String(data: try! JSONEncoder().encode(reply!), encoding: .utf8) ?? "fail" )")
//        }
//        m2.subscribe(key: "send_m1"){ message in
//            let key = message.key ?? ""
//            let data = message.data as? Int ?? -1
//            print("m2 receive!! key: \(key) | data: \(data)")
//            
//            XCTAssertEqual(key, "send_m1")
//            XCTAssertEqual(data, 127)
//            
//            let reply = Reply(result: data, resultDeco: "[\(data)]")
//            let replyMessage = Message(key: "send_m2", data: reply)
//            m2.publish(message: replyMessage)
//        }
//        
//        let message = Message(key: "send_m1", data: 127)
//        m1.publish(message: message)
//    }
    
    func testSerialize() throws{
        let reply = Reply(result: 1, resultDeco: "abc")
//        let m = Message(key: "rp", data: reply)
//        let d = m.serialize()
        let m = Payload(key:"rp", data: reply)
        print("m.key : \(m.info.key)   m.dataJson : \(m.json)" )
        let d : Reply? = m.data()
        print("d.result : \(d?.result ?? -1) d.resultDeco : \(d?.resultDeco ?? "")")
        
        let encodedInfo = try? m.encodeInfo()
        print("m.encodedInfo : \(encodedInfo ?? "")")
        
    }
    
    struct Reply : Codable{
        let result: Int
        let resultDeco: String
    }

}
