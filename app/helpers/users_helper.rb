module UsersHelper
  def user_avatar(user, size)
    image_tag user.avatar_url, {
      class: 'nav-avatar',
      alt: "#{user.github_username}'s avatar",
      title: user.github_username,
      size: size.to_s
    }
  end
end
