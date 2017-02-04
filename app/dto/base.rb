module Dto
  class Base < Struct.new(:object)
    include Rails.application.routes.url_helpers

    def as_json(*args)
      to_hash
    end
  end
end
