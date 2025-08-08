//
//  MyWidgetBundle.swift
//  MyWidget
//
//  Created by 박성훈 on 8/8/25.
//

import WidgetKit
import SwiftUI

@main
struct MyWidgetBundle: WidgetBundle {
    var body: some Widget {
        MyWidget()
        MyWidgetControl()
        MyWidgetLiveActivity()
    }
}
