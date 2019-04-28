require 'pry'
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do

  end

  get '/articles/new' do
    erb :new
  end

  post '/articles' do
    @article = Article.create(title: params[:title], content: params[:content])
    #binding.pry

    redirect to "/articles/#{Article.last.id}"
  end

  get '/articles' do
    @articles=Article.all

    erb :index
  end

  get '/articles/:id/edit' do
    @article = Article.find(params[:id])

    erb :edit
  end

  patch '/articles/:id' do
    @article = Article.find(params[:id])
    @article.update(title: params[:title])
    @article.update(content: params[:content])
    Article.save

  end

  get '/articles/:id' do
    @article = Article.find(params[:id])

    erb :show
  end

  delete '/articles/:id/delete' do
    @article= Article.find(params[:id])
    @article.destroy

    erb :index
  end
end
