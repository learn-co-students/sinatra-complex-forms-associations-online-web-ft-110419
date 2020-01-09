class OwnersController < ApplicationController

  get '/owners' do
    @owners = Owner.all
    erb :'/owners/index' 
  end

  get '/owners/new' do 
    @pets = Pet.all
    erb :'/owners/new'
  end

  post '/owners' do 
    if params[:pet][:name].length > 0 
      new_pet = Pet.create(name: params[:pet][:name])
      if params[:owner][:pet_ids]
        params[:owner][:pet_ids] << new_pet.id
      else 
        params[:owner][:pet_ids] = ["#{new_pet.id}"]
      end
    end
    @owner = Owner.create(params[:owner])
    redirect "/owners/#{@owner.id}"
  end

  get '/owners/:id/edit' do 
    @owner = Owner.find(params[:id])
    @pets = Pet.all
    erb :'/owners/edit'
  end

  get '/owners/:id' do 
    @owner = Owner.find(params[:id])
    erb :'/owners/show'
  end

  patch '/owners/:id' do 
    @owner = Owner.find(params[:id])
    if !params[:pet][:name].empty? && params[:owner][:pet_ids]
      params[:owner][:pet_ids] << Pet.create(params[:pet]).id
    end 
    if !params[:pet][:name].empty? && !params[:owner][:pet_ids]
      params[:owner][:pet_ids] = ["#{Pet.create(params[:pet]).id}"]
    end
    @owner.update(params[:owner])
    erb :'owners/show'
  end
end