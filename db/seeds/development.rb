l1 = List.create!(name: 93)
l2 = List.create!(name: 94)

m1 = Member.create!(name: "hoge", email: "hoge@example.com")
m2 = Member.create!(name: "fuga", email: "fuga@example.com")

l1.members << m1
l1.members << m2
l2.members << m1
l2.members << m2
