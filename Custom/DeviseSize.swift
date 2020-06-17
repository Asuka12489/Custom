//
//  DeviseSize.swift
//  Custom
//
//  Created by 竹村明日香 on 2020/06/17.
//  Copyright © 2020 Takemura assan. All rights reserved.
//

import UIKit

struct DeviseSize {
    
    //CGRectを取得
    static func bounds()->CGRect{
        return UIScreen.main.bounds;
    }
    
    //画面の横サイズを取得
    static func screenWidth()->Int{
        return Int( UIScreen.main.bounds.size.width);
    }
    
    //画面の縦サイズを取得
    static func screenHeight()->Int{
        return Int(UIScreen.main.bounds.size.height);
    }
}


