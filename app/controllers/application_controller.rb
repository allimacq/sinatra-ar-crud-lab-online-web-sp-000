
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
    
    @new = Article.create(title: @title, content: @content)
   
    @id = @new.id
    redirect to "/articles/#{@id}"
  end
  
  get '/articles/:id/edit' do
    @id = params[:id]
    @article2 = Article.find_by(id: @id.to_i)
    
    erb :edit
  end
  
  patch '/articles/:id' do
    @id = params[:id]
    @to_update = Article.find_by(id: @id.to_i)
    
    @to_update.title = params[:title]
    @to_update.content = params[:content]
    @to_update.save
    
    redirect to "/articles/#{@id}"
  end
  
end
