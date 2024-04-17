
require_relative '../nusa/renderer'

namespace :render do
  desc 'Render configuration and compose files and keys'
  task :config do
    renderer = Nusa::Renderer.new
    renderer.render_keys
    renderer.render
  end
end
