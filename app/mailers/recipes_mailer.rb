class RecipesMailer < ApplicationMailer
  def send_recipe(recipe_id, name_from, email_to, msg)
    @name_from = name_from
    @email_to = email_to
    @msg = msg
    @recipe = Recipe.find(recipe_id)
    mail(to: [email_to], subject: "#{name_from} te enviou uma receita")
  end
end