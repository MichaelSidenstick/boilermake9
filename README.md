# Inspiration
Based on the idea of a suspended coffee, the idea of being able to get access to a free coffee with no questions asked, our team was inspired to help college students who struggle be able to obtain the food they need to live a healthy life. The concept is that a student can anonymously post their grocery lists online, with no questions asked, and anyone can purchase these orders online for in-store pickup for the student.

# What it does
This is a web application in which people can create an account to post their grocery lists online. Students have access to search and request for any items sold within Kroger stores. After creating their grocery list, the student anonymously posts it online and awaits a donor to purchase the contents of the grocery list for them.

# How we built it
The web application was built using Ruby on Rails for front-end and back-end development. For the database, Postgresql was used and the database and website is hosted on Heroku. The Kroger Api was used for searching items and automatically adding a student's grocery list directly to the donor Kroger's online shopping cart.

# Challenges we ran into
While working with various api's trying to find out which one to use for online grocery shopping, many issues with authentication occurred. The Kroger Api was finally selected as the team's choice due to the ability to search items and add items directly to your online shopping cart. The team also was not too familiar with Ruby on Rails; it was certainly a learning experience and many errors occurred due to some of the abstractions of the code making it hard to follow along

# What's next for FeedItForward
Going forward, the web application needs slightly more polishing to have a more appealing and intuitive interface. Also, the option to have student's groceries delivered, while protecting the student safety by hiding addresses, is another important feature going forward.
