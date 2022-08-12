//
//  Tools.swift
//  UI-641
//
//  Created by nyannyan0328 on 2022/08/12.
//

import SwiftUI

struct Tools: Identifiable {
    var id = UUID().uuidString
    var icon : String
    var name : String
    var color : Color
    var toolPostion : CGRect = .zero
}

