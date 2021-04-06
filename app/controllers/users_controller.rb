class UsersController < ApplicationController

    get '/signup' do
        if session[:user_id]
            redirect "/users/#{session[:user_id]}"
        end
        erb :'users/signup'
    end

    post '/signup' do
        u = User.new(params[:user])
        if u.save
            session[:user_id] = u.id
            redirect "/users/#{@u.id}"
        else
            erb :'/users/signup'
        end
    end

    get '/users/:id' do
        @user = User.find_by(id: params[:id])
        @cosmetics = @user.cosmetics
        erb :'users/show'
    end

    get '/login' do
        if session[:user_id]
            redirect "/users/#{session[:user_id]}"
        end
        erb :'users/login'
    end

    post '/login' do
        u = User.find_by(username: params[:user][:username])
        if u && user.authenticate(params[:user][:password])
            session[:user_id] = u.id
            redirect "/users/#{u.id}"
        else
            erb :'users/login'
        end
    end

    get '/logout' do
        session.clear
        redirect '/'
    end

    get '/users' do
        @users = User.all
        erb :'users/index'
      end

end