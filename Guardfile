guard :rspec, cmd: 'bundle exec rspec' do
  watch(%r{^spec/.+_spec\.rb$})
  watch('spec/spec_helper.rb')        { 'spec' }

  watch(%r{^(\w+)\.rb$})              { 'spec' }

  watch(%r{^lib/(.+)\.rb$})           { |m| "spec/lib/#{m[1]}_spec.rb" }

  watch(%r{^views/(.+)\.(erb|slim)$}) { |m| "spec/features/#{m[1]}_spec.rb" }
end