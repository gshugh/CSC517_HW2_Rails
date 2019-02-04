require 'test_helper'

class RecipeCreationFlowTest < ActionDispatch::IntegrationTest
  test "recipe creation flow should happen with user input" do

    visit '/recipes/new'

    fill_in 'Title',:with => "Some recipe name"
    fill_in 'Description',:with => "Some recipe description"
    fill_in 'Instructions',:with => "Some recipe instructions"
    # See https://piazza.com/class/jqfwko22hpd5rk?cid=131
    select "Some_Category",:from => "recipe_category_id"

    click_button 'Create Recipe'

    assert page.has_content?("Recipe was successfully created.")
    assert page.has_content?("Some recipe name")
    assert page.has_content?("Some recipe description")
    assert page.has_content?("Some recipe instructions")

  end
end
