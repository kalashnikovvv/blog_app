def random_time
  rand(60).days.ago
end

def create_article(user, tag_list, visible = true)
  tag_count = rand(8)
  tags = tag_list.shuffle[0..tag_count]
  user.articles.create title: Faker::Lorem.sentence[0..-2],
                       text: Faker::Lorem.paragraphs(10).join(" "),
                       visible: visible,
                       publish_date: random_time,
                       tags: tags
end


user1 = User.create email: "vasya@test.com", password: "testpass1", username: "vasya"
user2 = User.create email: "petya@test.com", password: "testpass2", username: "petya"
user3 = User.create email: "masha@test.com", password: "testpass3", username: "masha"

tag_list = Faker::Lorem.words(20).uniq

10.times { create_article(user1, tag_list) }
3.times { create_article(user1, tag_list, false) }

6.times { create_article(user2, tag_list) }

16.times { create_article(user3, tag_list) }
3.times { create_article(user3, tag_list, false) }


users = User.all
Article.all.each do |article|
  root_comment_count = rand(5)
  root_comment_count.times do
    time = random_time
    article.comments.create text: Faker::Lorem.paragraph,
                            user: users.sample,
                            article: article,
                            created_at: time,
                            updated_at: time
  end

  next if root_comment_count == 0

  rand(15).times do
    time = random_time
    article.comments.create text: Faker::Lorem.paragraph,
                            user: users.sample,
                            article: article,
                            parent: article.comments.order("RANDOM()").take,
                            created_at: time,
                            updated_at: time
  end
end
