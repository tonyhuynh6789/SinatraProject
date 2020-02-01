class FavoriteListsController < ApplicationController 
    

    get '/favorites' do 
        redirect_if_not_logged_in
        @favorites = current_user.favorites
        erb :'favorites/favorites'
    end 
    


    get '/favorites/new' do 
        redirect_if_not_logged_in
        erb :'favorites/create_favorite' 
    end 
    
    

    post '/favorites' do 
        redirect_if_not_logged_in
        if params[:content].blank?
           flash[:notice] = "The field is blank. Fill in bellow:"
           redirect "/favorites/new"
        else 
            @favorite = current_user.favorites.create(:content => params[:content])
            flash[:notice] = "Your Favorite Has Been Succesfully Created"
            redirect '/favorites'  
        end 
       
    end 
    
    

    get '/favorites/:id' do
        redirect_if_not_logged_in
            @favorite = Favorite.find_by(id: params[:id])
            erb :'favorites/show_favorite'
    end


    

    
    delete '/favorites/:id/delete' do
        redirect_if_not_logged_in
           @favorite = Favorite.find_by(id: params[:id])
           if_user_and_user_of_favorite_is_not_current_user
           @favorite.delete
           flash[:notice] = "Favorite successfully removed!"
           redirect '/favorites'
    end 
    
    
    
    get '/favorites/:id/edit' do
        redirect_if_not_logged_in
            @favorite = Favorite.find_by_id(params[:id])
            if_user_and_user_of_favorite_is_not_current_user
            erb :'favorites/edit'   
    end
    
    
    
    patch '/favorites/:id' do  
        redirect_if_not_logged_in
        if params[:content].blank?
            flash[:notice] = "Field is unfilled"
            redirect "/favorites/#{params[:id]}/edit"
        else 
            @favorite = Favorite.find_by(:id => params[:id])
            if_user_and_user_of_favorite_is_not_current_user
            @favorite.content = params[:content]
            @favorite.save 
            flash[:notice] = "Your Favorite Has Been Succesfully Updated"
            redirect '/favorites'
        end 
    end     
end     