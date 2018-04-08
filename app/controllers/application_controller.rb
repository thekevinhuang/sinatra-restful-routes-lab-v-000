class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/recipes' do
    @recipes = Recipe.all
    erb :index
  end

  get '/recipes/new' do
    erb :new
  end

  post '/recipes' do
    @recipe = Recipe.create(name: params[:name], ingredients: params[:ingredients], cook_time: params[:cook_time])
    redirect to "/recipes/#{@recipe.id}"
  end

  get '/recipes/:id' do
    @recipe = current_post(params[:id])
    erb :show
  end

  get '/recipes/:id/edit' do
    @recipe = current_post(params[:id])
    erb :edit
  end

  patch '/recipes/:id' do
    @recipe = current_post(params[:id])
    @recipe.name = params[:name]
    @recipe.ingredients = params[:ingredients]
    @recipe.cook_time = params[:cook_time]
    @recipe.save
    redirect to "/recipes/#{@recipe.id}"
  end

  delete '/recipes/:id' do
    @recipe = current_post(params[:id])
  end

  helpers do
		def current_post(id_param)
			Recipe.find_by_id(id_param)
		end
	end
end
