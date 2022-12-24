class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user
  has_rich_text :body

  # callback methods for notifiactions refered from chris oliver NOTICED gem
  after_create_commit(:notify_recipient) # this callback function will run after new comment has been created and saved to DB
  before_destroy(:cleanup_notifications) # this callback fucntion will run before the notification is deleted from DB
  has_noticed_notifications(model_name: "Notifications")

  private

  def notify_recipient
    CommentNotification.with(comment: self, post: post).deliver_later(post.user)
    # deliver_later(post.user) means we deliver notification to the user who created post thats why we passed post.user
    # .with(comment: self, post: post) are params passed while creating notifications
    # the following is notification object created

    #   [#<Notification:0x00007fcb4fd56b60
    # id: 1,
    # recipient_type: "User",
    # recipient_id: 1,
    # type: "CommentNotification",
    # params:
    #  {:post=>
    #    #<Post:0x00007fcb4fcf4ca8
    #     id: 30,
    #     title: "Title 9",
    #     body: "Body 9 has description",
    #     created_at: Fri, 23 Dec 2022 10:16:30.621228000 UTC +00:00,
    #     updated_at: Sat, 24 Dec 2022 05:29:24.408558000 UTC +00:00,
    #     views: 99,
    #     user_id: 1>,
    #   :comment=>
    #    #<Comment:0x00007fcb4faaa268
    #     id: 22,
    #     post_id: 30,
    #     user_id: 7,
    #     created_at: Sat, 24 Dec 2022 05:29:13.802159000 UTC +00:00,
    #     updated_at: Sat, 24 Dec 2022 05:29:13.815127000 UTC +00:00>},
    # read_at: nil,
    # created_at: Sat, 24 Dec 2022 05:29:13.853076000 UTC +00:00,
    # updated_at: Sat, 24 Dec 2022 05:29:13.853076000 UTC +00:00>]

  end

  def cleanup_notifications
    notifications_as_comment.destroy_all
    # OR
    # Notification.where(comment_id: comment_id).destroy_all
  end
end
