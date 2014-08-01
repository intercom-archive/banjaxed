module UsersHelper
  def user_gravatar(user, size)
    src = "//gravatar.com/avatar/#{user.gravatar_hash}?s=#{size}&d=mm"
    image_tag src, class: 'nav-gravatar', alt: "#{user.github_username}'s gravatar", title: user.github_username
  end
end
