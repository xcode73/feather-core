//
//  File.swift
//  
//
//  Created by Tibor Bodecs on 2021. 12. 01..
//

import SwiftHtml

public struct MultifileFieldTemplate: TemplateRepresentable {

    public var context: InputFieldContext
    
    public init(_ context: InputFieldContext) {
        self.context = context
    }
    
    @TagBuilder
    public func render(_ req: Request) -> Tag {
        LabelTemplate(context.label).render(req)

        Input()
            .type(.file)
            .multiple()
            .key(context.key + "[]")
//            .accept("")
            .class("field")
        if let error = context.error {
            Span(error)
                .class("error")
        }
    }
}
