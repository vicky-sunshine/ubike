Dir.glob('./{config,models,controllers,lib}/init.rb').each do |file|
  require file
end

run YoubikeAPI
