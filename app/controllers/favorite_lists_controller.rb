class FavoriteListsController < ApplicationController 
    
get '/favorites' do 
       redirect_if_not_logged_in
       @favorites = current_user.favorites
       erb :'favorites/favorites'
end 

get '/favorites/new' do 
    if logged_in?
        erb :'favorites/create_favorite'
    else 
        redirect '/login'
    end 
end 


post '/favorites' do 
    if logged_in?
        if params[:content].blank?
            flash[:notice] = "The field is blank. Fill in bellow:"
           redirect "/favorites/new"
        else 
        @favorite = current_user.favorites.create(:content => params[:content])
        flash[:notice] = "Your Task Has Been Succesfully Created"
        redirect '/favorites'  
        end 
    else 
        redirect '/login'
    end 
end 


get '/favorites/:id' do
  if logged_in?
      @favorite = Favorite.find_by(id: params[:id])
      erb :'favorites/show_favorite'
  else
    redirect '/login'
  end

end


delete '/favorites/:id/delete' do
    if logged_in?
        @favorite = Favorite.find_by(id: params[:id])
        if @favorite && @favorite.user == current_user
           @favorite.delete
           flash[:notice] = "Task successfully removed!"
        end 
        redirect '/favorites'
    else 
        redirect '/login'
    end
end 



get '/favorites/:id/edit' do
    if logged_in?
        @favorite = Favorite.find_by_id(params[:id])
        if @favorite && @favorite.user == current_user
           erb :'favorites/edit'
        else 
           flash[:notice] = "You are not authorized to edit this task."
           redirect to '/login'
        end 
    end
end



patch '/favorites/:id' do 
    if logged_in?
        if params[:content].blank?
            flash[:notice] = "Field is unfilled"
            redirect "/favorites/#{params[:id]}/edit"
        else 
             @favorite = Favorite.find_by(:id => params[:id])
            if @favorite && @favorite.user == current_user
            @favorite.content = params[:content]
            @favorite.save 
            flash[:notice] = "Your Task Has Been Succesfully Updated"
            end   
            redirect '/favorites'
        end 
    else 
        redirect '/login'
    end  
end 


   



   


    
end 