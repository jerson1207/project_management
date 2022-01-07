user1 = User.create(email: "user1@test.com", password: "123456", password_confirmation: "123456")
puts "user1 has been created"
  project1 = user1.projects.new(name: "Website for Coffee Store", progress: 0, deadline: Date.new(2022,9,14))
  project1.save
  puts "project 1 has been created"
    cat1 = project1.categories.new(name: "Project Planning", progress: 50, deadline: Date.new(2022,9,14))
    cat1.save
    puts "category 1 has been created"
        task1 = cat1.tasks.new(name: "Tell everyone you know that your site is online and keep working on your marketing plan.", complete: false, timelimit: false, deadline: Date.new(2022,9,14))
        task1.save
        task2 = cat1.tasks.new(name: "Publish your site on the Web.", complete: true)
        task2.save
        puts "2 task has been created under category1"

    cat2 = project1.categories.new(name: "Product roadmap creation")
    cat2.save
    puts "category 2 has been created"

    cat3 = project1.categories.new(name: "Release planning")
    cat3.save
    puts "category 3 has been created"

    cat4 = project1.categories.new(name: "Sprint planning")
    cat4.save
    puts "category 4 has been created"
    cat5 = project1.categories.new(name: "Daily stand-ups")
    cat5.save
    puts "category 5 has been created"
    cat6 = project1.categories.new(name: "Sprint review and retrospective")
    cat6.save
    puts "category 6 has been created"