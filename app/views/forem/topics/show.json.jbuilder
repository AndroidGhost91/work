json.topic @topic

json.posts @topic.posts.map { |p| Dto::Board::ThreadPost.new(p) }
