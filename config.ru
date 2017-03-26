Dir.glob('./{config,models,controllers,services,lib}/init.rb').each do |file|
  require file
end

run YoubikeAPI
