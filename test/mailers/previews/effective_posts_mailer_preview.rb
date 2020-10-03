# In Rails 4.1 and above, visit:
# http://localhost:3000/rails/mailers
# to see a preview of the following 3 emails:

class EffectivePostsMailerPreview < ActionMailer::Preview
  def post_submitted_to_admin
    Effective::PostsMailer.post_submitted_to_admin(build_preview_post)
  end

  protected

  def build_preview_post
    post = Effective::Post.new(
      title: 'A post',
      category: EffectivePosts.categories.first.presence || 'posts',
      published_at: Time.zone.now,
      draft: true,
      body: 'This is a new post that has been submitted by a public user.'
    )
  end

end
