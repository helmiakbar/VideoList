//
//  Index.swift
//  iOS-BaseTests
//
//  Created by Helmi Akbar on 19/08/18.
//  Copyright © 2018 Lutfi Azhar. All rights reserved.
//

import XCTest
import Quick
import Nimble

@testable import iOS_Base

class ProviderSpec: QuickSpec {
    
    override func spec() {
        
        describe("Movie List Service") {
            
            let service = APIService.sharedInstance
            
            context("After connected to server") {
                
                it("can parse movies data") {
                    
                    service.getMoviesAPI(success: { (data) in
                        
                        //MovieLists
                        expect(data).toNot(beNil())
                        expect(data[0]).to(beAKindOf(Movie.self))
                        
                    }) { (message: String) in
                        
                        expect(message).toNot(beNil())
                        
                    }
                }
                
            }
            
        }
        
        describe("Movie List Manager") {

            let manager = APIManager.sharedInstance

            context("After connected to server") {

                it("can get data") {
                    manager.GETAPIWithResponseObject(route: Constant.RouteGetMoview + "?api_key=27d1b110362231ee861826f428440e1a&language=en-US&page=1", successBlock: { (_ responseObject: [String: Any]) -> Void in
                        expect(responseObject).toNot(beNil())
                    }, failureBlock: { (_ errorMessage: String) -> Void in
                        expect(errorMessage).toNot(beNil())
                    })
                }

            }

        }
    }
    
}

