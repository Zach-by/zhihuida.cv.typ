// url预处理
#let url(url-str) = {
  let prefix = regex("http[s]?://")

  // url必须以http:// 或 https://开头
  if not url-str.starts-with(prefix) {
    panic("url must start with http:// or https://")
  }

  url-str = url-str.replace(prefix, "")
  // 去掉末尾的/
  if url-str.ends-with("/") {
    url-str = url-str.slice(0, url.len() - 1)
  }

  if url-str.starts-with("github.com/") {
    url-str = url-str.replace("github.com/", "")
  }

  return url-str
}

// github 链接
#let github(url-str) = {
  let prefix = regex("http[s]?://github.com/")
  if not url-str.starts-with(prefix) {
    panic("github url must start with http[s]://github.com/")
  }

  return link(url-str)[
    #set box(height: 1em)
    #box(image("./icons/github.svg"), baseline: 0.75pt)
    #text(weight: "regular")[
      #url(url-str)
    ]
  ]
}

// 分节信息
#let section-header(title: "", icon: "") = {
  grid(
    columns: (1fr),
    row-gutter: 3pt,
    align(left)[
      #if icon != "" {
        box(image(icon), height: 1.4em, baseline: 2pt)
        h(1pt)
      }
      #text(weight: "black", 1.4em, title)
    ],
    line(stroke: 0.5pt+gray, length: 100%)
  )
}


#let cv(name: "", phone: "", email: "", website: "", avatar: "", body) = {
  set document(title: name)
  set page(paper: "a4", margin: (x: 2.1cm, y: 1.2cm))
  set text(font: "Times New Roman", 0.9em, weight: "regular");
  set par(justify: true, linebreaks: "optimized")

  align(center)[
    // 名字
    #block(text(weight: "black", 2.4em, name))
    #if avatar != "" {
      place(top + right, dy: -3em)[
        #block(image(avatar), height: 5em, width: 6em)
      ]
    }
    

    // 其他信息
    #set text(size: 0.9em)
    #set box(baseline: 0.1em, height: 1em)
    #grid(
      columns: (auto, auto, auto, auto, auto, auto, auto),
      column-gutter: 0.8em,
      link("")[
        #box(image("./icons/phone.svg"))
        #phone
      ],
      text(weight: "regular", baseline: 2pt)[
        ·
      ],
      link("mailto:" + email)[
        #box(image("./icons/envelope.svg"))
        #email
      ],
      text(weight: "regular", baseline: 2pt)[
        ·
      ],
      link(website)[
        #box(image("./icons/website.svg"))
        #url(website)
      ]
    )
  ]
  body
}

// 教育背景
#let educations(educations) = {
  section-header(title: "Educations", icon: "./icons/education.svg")
  set text(1em)

  for education in educations {
    block[
      #text(weight: "black", education.school + ",")
      #h(3pt)
      #education.major
      #h(1fr)
      #text(education.degree)
      #h(3pt)
      #text(0.9em, weight: "thin", emph(education.date))
      #v(-4pt)
    ]
  }

  v(-1pt)
}

// 校园经历
#let schools(schools) = {
  section-header(title: "Campus Experience", icon: "./icons/school.svg")
  set list(indent: 1em, tight: true)

  for school in schools {
    block[
      #text(1.25em, weight: "black", school.dapartment)
      #h(3pt)
      #school.jobtitle
      #h(1fr)
      #text(weight: "thin", emph(school.date))
      
      #for point in school.points.map(x => "[" + x + "]") {
        list(eval(point))
      v(-3pt)
      }

      #v(-1pt)
    ]
  }
}

// 项目经历
#let projects(projects) = {
  section-header(title: "Project Experience", icon: "./icons/project.svg")

  set list(indent: 1em, tight: true)

  for project in projects {
    block[
      #text(1.25em, weight: "black", project.name)
      #if project.url != "" {
        h(3pt)
        github(project.url)
      }
      #h(1fr)
      #text(weight: "thin", emph(project.date))

      #if project.desc != "" {
        v(-5pt)
        text(weight: "black", project.desc)
      }

      #for point in project.points {
        list(point)
        v(-5pt)
      }
      #v(-1pt)
    ]
  }
}

// 实习经历
#let internships(internships) = {
  section-header(title: "Internships", icon: "./icons/internship.svg")
  set list(indent: 1em, tight: true)

  for internship in internships {
    block[
      #text(1.25em, weight: "black", internship.company)
      #h(3pt)
      #internship.jobtitle
      #h(1fr)
      #text(weight: "thin", emph(internship.date))
      
      #for point in internship.points.map(x => "[" + x + "]") {
        list(eval(point))
      v(-5pt)
      }
      #v(-1pt)
    ]
  }
}

// 荣誉奖项
#let awards(awards) = {
  section-header(title: "Awards", icon: "./icons/award.svg")
  set list(tight: true, marker: none, body-indent: 0pt)

  for award in awards {
    list[
      #award.name
      #h(1fr)
      #text(weight: "thin", emph(award.date))
      #v(-1pt)
    ]
  }
}

// 个人技能
#let skills(skills) = {
  section-header(title: "Skills", icon: "./icons/skill.svg")
  set list(tight: true, marker: none, body-indent: 0pt)

  for skill in skills {
    list[
      #skill.name
      #h(1fr)
      #text(weight: "regular", emph(skill.desc))
      #v(-3pt)
    ]
  }
}