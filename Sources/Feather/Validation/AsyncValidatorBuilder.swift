//
//  File.swift
//  
//
//  Created by Tibor Bodecs on 2021. 11. 29..
//

import Vapor
@resultBuilder
public enum AsyncValidatorBuilder {
    
    public static func buildBlock(_ components: AsyncValidator...) -> [AsyncValidator] {
        components
    }
}
