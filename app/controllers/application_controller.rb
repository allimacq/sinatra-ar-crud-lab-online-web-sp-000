
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  #get '/' do
  #end
  
   get '/articles' do
    @articles = Article.all
    
    erb :index
  end
  
  get '/articles/new' do
    erb :new
  end
  
  get '/articles/:id' do
    @id = params[:id]
    @article = Article.find_by(id: @id.to_i)
    
    @title = @article.title
    @content = @article.content
  
     erb :show
  end
  
   post '/articles' do
    @title = params[:title]
    @content = params[:content]
    
    @article = Article.create(title: @title, content: @content)
   
    @id = @article.id
    redirect to "/articles/#{@id}"
  end
  
  get '/articles/:id/edit' do
    @id = params[:id]
    @article = Article.find_by(id: @id.to_i)
    
    erb :edit
  end
  
  patch '/articles/:id' do
    @id = params[:id]
    @article = Article.find_by(id: @id.to_i)
    
    @article.title = params[:title]
    @article.content = params[:content]
    @article.save
    
    redirect to "/articles/#{@id}"
  end
  
  delete '/articles/:id' do
    @id = params[:id]
    @article = Article.find_by(id: @id.to_i)
    @article.delete
    
    redirect to "/articles"
  end
  
end
