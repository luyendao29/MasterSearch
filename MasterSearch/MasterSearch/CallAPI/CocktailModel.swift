//
//  CocktailModel.swift
//  MasterSearch
//
//  Created by Boss on 9/10/20.
//  Copyright © 2020 LuyệnĐào. All rights reserved.
//

import UIKit

struct BaseDataModel: Codable {
    var drinks: [CocktailModel]?
}
struct CocktailModel: Codable {
    var strDrink: String?
    var strDrinkThumb: String?
    var idDrink: String?
}
