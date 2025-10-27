#import "template.typ": *

// 加载数据
#let data = toml("main.toml")

#let (name, email, phone, website, avatar) = data.cv;
#show: cv.with(
  name: name, 
  email: email, 
  phone: phone, 
  website: website, 
  avatar: avatar
)

#educations(data.educations)
#schools(data.schools)
#projects(data.projects)
#internships(data.internships)
#awards(data.awards)
#skills(data.skills)