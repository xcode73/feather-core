//
//  File.swift
//  
//
//  Created by Tibor Bodecs on 2021. 12. 22..
//

import Vapor

final class SystemFileCreateDirectoryForm: AbstractForm {

    var name: String!
    
    init() {
        super.init()
        self.submit = "Create"
    }

    @FormFieldBuilder
    override func createFields(_ req: Request) -> [FormField] {
        InputField("name")
            .config {
                $0.output.context.label.required = true
            }
            .validators {
                FormFieldValidator.required($1)
            }
            .read { [unowned self] req, field in self.name = field.input }
    }
}
