require 'marginalia'
Marginalia::Railtie.insert

Marginalia::Comment.components = [:controller_with_namespace, :action, :line]

#Marginalia::Comment.prepend_comment = true
