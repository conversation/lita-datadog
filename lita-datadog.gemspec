Gem::Specification.new do |spec|
  spec.name = "lita-datadog"
  spec.version = "0.1.2"
  spec.summary = "Lita handler for interacting with datadoghq.com, a hosted monitoring / analytics app"
  spec.description = "Lita handler for interacting with datadoghq.com, a hosted monitoring / analytics app"
  spec.license = "MIT"
  spec.files =  Dir.glob("{lib}/**/**/*")
  spec.extra_rdoc_files = %w{README.md MIT-LICENSE }
  spec.authors = ["Mark Cipolla"]
  spec.email   = ["mark.cipolla@theconversation.edu.au"]
  spec.homepage = "http://github.com/conversation/lita-datadog"
  spec.required_ruby_version = ">=2.0"
  spec.metadata = { "lita_plugin_type" => "handler" }

  spec.add_development_dependency("rake")
  spec.add_development_dependency("rspec", "~> 3.4")
  spec.add_development_dependency("pry")
  spec.add_development_dependency("rdoc")

  spec.add_dependency("lita")
  spec.add_dependency("dogapi")
end
