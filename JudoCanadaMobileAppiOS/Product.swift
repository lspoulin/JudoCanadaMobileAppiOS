//
//  Product.swift
//  JudoCanadaMobileAppiOS
//
//  Created by Louis-Simon Poulin on 2018-06-07.
//  Copyright © 2018 Louis-Simon Poulin. All rights reserved.
//

import Foundation
import ObjectMapper

struct Product:Mappable {
    var entityId:Int = 0
    var typeId:String = ""
    var sku:String = ""
    var description:String = ""
    var metaKeyword:String = ""
    var shortDescription:String = ""
    var name:String = ""
    var metaTitle:String = ""
    var metaDescription:String = ""
    var regularPriceWithTax:Double = 0.0
    var regularPriceWithoutTax:Double = 0.0
    var finalPriceWithTax:Double = 0.0
    var finalPriceWithoutTax:Double = 0.0
    var isSaleable:Bool = false
    var imageUrl:String = ""
    
    init(){
        
    }
    
    init?(map: Map) {
        entityId <- map["entity_id"]
        typeId    <- map["type_id"]
        sku <- map["sku"]
        description <- map["description"]
        metaKeyword <- map["meta_keyword"]
        shortDescription <- map["short_description"]
        name <- map["name"]
        metaTitle <- map["meta_title"]
        metaDescription <- map["meta_description"]
        regularPriceWithTax <- map["regular_price_with_tax"]
        regularPriceWithoutTax <- map["regular_price_without_tax"]
        finalPriceWithTax <- map["final_price_with_tax"]
        finalPriceWithoutTax <- map["final_price_without_tax"]
        isSaleable <- map["is_saleable"]
        imageUrl <- map["image_url"]
    }
    
    
    mutating func mapping(map: Map) {
        entityId <- map["entity_id"]
        typeId    <- map["type_id"]
        sku <- map["sku"]
        description <- map["description"]
        metaKeyword <- map["meta_keyword"]
        shortDescription <- map["short_description"]
        name <- map["name"]
        metaTitle <- map["meta_title"]
        metaDescription <- map["meta_description"]
        regularPriceWithTax <- map["regular_price_with_tax"]
        regularPriceWithoutTax <- map["regular_price_without_tax"]
        finalPriceWithTax <- map["final_price_with_tax"]
        finalPriceWithoutTax <- map["final_price_without_tax"]
        isSaleable <- map["is_saleable"]
        imageUrl <- map["image_url"]
    }
}

