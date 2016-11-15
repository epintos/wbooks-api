class AuthenticationDecodedToken < HashWithIndifferentAccess
  def expired?
    return false unless self[:expiration_date].present?
    Time.zone.now.to_i > self[:expiration_date]
  end

  def valid_verification_code?
    return true unless self[:verification_code].present?
    User.find(self[:user_id]).verification_code == self[:verification_code]
  end

  def warning_expiration_date_reached?
    return false unless self[:warning_expiration_date].present?
    Time.zone.now.to_i >= self[:warning_expiration_date]
  end

  def valid_refresh_id?(refresh_id)
    return true unless self[:refresh_id].present? && refresh_id.present?
    refresh_id == self[:refresh_id]
  end

  def able_to_refresh?
    return true unless self[:expiration_date].present? && self[:maximum_useful_date].present?
    self[:expiration_date] < self[:maximum_useful_date]
  end
end
