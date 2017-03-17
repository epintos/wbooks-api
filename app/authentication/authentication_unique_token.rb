class AuthenticationUniqueToken
  class << self
    # I'm not checking the uniqueness because its unlikely to happen
    def generate
      SecureRandom.hex(16)
    end

    def generate_friendly(length = 32)
      rlength = (length * 3) / 4
      SecureRandom.urlsafe_base64(rlength).tr('lIO0', 'sxyz')
    end
  end
end
