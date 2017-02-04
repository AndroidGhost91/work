module CzardomAdmin
  class Engine < ::Rails::Engine
    isolate_namespace CzardomAdmin

    # config.assets.paths << Rails.root.join('vendor', 'assets', 'components')
  end
end
