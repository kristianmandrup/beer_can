guard 'coffeescript', :output => 'lib' do  
  watch(%r{^src\/(.+\.coffee)$})
end

guard 'coffeescript', :output => 'spec/javascripts' do
  watch(%r{^test\/(.+\.coffee)$})
end

guard 'jasmine-headless-webkit' do
  watch(%r{^lib/(.*)\.js}) { |m| newest_js_file("spec/javascripts/#{m[1]}_test") }
end
