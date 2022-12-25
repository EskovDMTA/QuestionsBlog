class UserDecorator < ApplicationDecorator
  delegate_all

  def name_or_email
    return name if name.present?
    email.split("a")[0]
  end

  def gravatar(size: 30, css_class: "")
    email_hash = Digest::MD5.hexdigest email.strip.downcase
    image_tag = "https://www.gravatar.com/avatar/#{email_hash}.jpg?s=#{size}"
  end
end
