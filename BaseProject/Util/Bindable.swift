//
//  Bindable.swift
//  BaseProject
//
//  Created by dongseok lee on 15/06/2019.
//  Copyright © 2019 Good Effect. All rights reserved.
//

import Foundation

/**

 Simple reactive binding wrapper protocol.
 
 - value: Reactive state. Using didSet for listening event is the easiest way.
 - bind: Closure for executing when value changed.

 DO NOT set 'value' in 'bind' closure. It will drag to recursive situtation.
*/
protocol Bindable {
    associatedtype T
    var value: T? { get set }
    var bind: ((T?) -> Void)? { get set }
}

final class PropertyBindable<Type>: Bindable {
    var bind: ((Type?) -> Void)?

    var value: Type? {
        didSet { bind?(value) }
    }
}

final class UIBindable<Type>: Bindable {
    var bind: ((Type?) -> Void)?
    
    var value: Type? {
        didSet {
            DispatchQueue.main.async {
                self.bind?(self.value)
            }
        }
    }
}
