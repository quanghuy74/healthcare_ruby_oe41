module AccountsHelper
  def gravatar_for account
    gravatar_id = Digest::MD5.hexdigest account.email.downcase
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
    image_tag gravatar_url, alt: account.name, class: "gravatar"
  end

  def render_details
    if current_account? @account
      render "customer_info"
    elsif @account.staff?
      render "staff_info"
    end
  end
end
