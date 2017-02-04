module CzardomMessages
  class EmailAddress
    attr_reader :username, :hash, :domain

    def initialize(address)
      @address = address
      before_domain, @domain = @address.split('@')
      @username, @hash = before_domain.split('+')
    end

    def valid_domain?
      domain == EmailParser::DOMAIN
    end

    def invalid_domain?
      !valid_domain?
    end

  end
end
