
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  # redirect root to /articles
  get '/' do
    redirect to '/articles'
  end

  # make all articles available to index
  get '/articles' do
    @articles = Article.all
    erb:index
  end

  # Create form
  get '/articles/new' do
    erb:new
  end

  # Create
  post '/articles' do
    Article.create(params)
    redirect to "/articles/#{Article.last.id}"
  end

  # Read
  get '/articles/:id' do
    @article = Article.find(params[:id])
    erb:show
  end

  # Update form
  get '/articles/:id/edit' do
    @article = Article.find(params[:id])
    erb:edit
  end

  # Update
  patch '/articles/:id' do
    @article = Article.find(params[:id])
    @article.update(params[:article])
    redirect to "/articles/#{article.id}"
  end

  # Delete
  delete "/articles/:id" do
    Article.destroy(params[:id])
    redirect to "/articles"
  end
end
