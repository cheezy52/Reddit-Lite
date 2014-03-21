json.(comment, :id, :body, :owner_id, :post_id, :parent_id, :created_at, :updated_at)
json.karma(comment.karma)
json.num_comments(comment.num_comments)
json.already_voted(comment.user_already_voted?(current_user))
if comment.user_already_voted?(current_user)
  json.upvoted(comment.user_upvoted?(current_user))
  json.vote_id(comment.user_vote_id(current_user))
end
json.owner_name(comment.owner.username)