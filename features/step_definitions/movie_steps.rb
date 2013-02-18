# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    Movie.create!(movie)
  end
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |movie1, movie2|
  pos1 = page.body.index(movie1)
  pos2 = page.body.index(movie2)
  assert pos1 < pos2
end

Given /^I should see the following movies:$/ do |table|
  table.hashes.each do |movie|
    step %{I should see "#{movie['title']}"}
  end
end

Given /^I should not see the following movies:$/ do |table|
  table.hashes.each do |movie|
    step %{I should not see "#{movie['title']}"}
  end
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  rating_list.split(/[, ]+/).each do |el|
    if uncheck
      step %{I uncheck "ratings_#{el}"}
    else
      step %{I check "ratings_#{el}"}
    end
  end
end

Then /^I should see no movies$/ do
  assert_equal 0, page.all('table tbody tr').size
end

Then /^I should see all of the movies$/ do
  assert_equal Movie.count, page.all('table tbody tr').size
end


Then /^the director of "([^"]*)" should be "([^"]*)"$/ do |arg1, arg2|
  assert page.body =~ /#{arg1}.+Director.+#{arg2}/m
end
