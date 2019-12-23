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
    new_owner = Owner.create(name: params[:owner][:name])
    if !params["pet"]["name"].empty?
      new_owner.pets.create(name: params["pet"]["name"])
    end
    if !params[:owner][:pet_ids].nil?
      params[:owner][:pet_ids].each do |id| 
        new_owner.pets << Pet.find_by_id(id)
      end
    end
    
    redirect "/owners/#{new_owner.id}"
  end

  get '/owners/:id/edit' do 
    @owner = Owner.find(params[:id])
    @pets = Pet.all
    erb :'/owners/edit'
  end
  
  patch '/owners/:id' do
    owner_id = params[:id]
    owner_name = params[:owner][:name]
    pets_ids = params[:owner][:pet_ids]
    pet_name = params[:pet][:name]
    
   owner = Owner.find(owner_id)
   owner.update(name: owner_name)
   Pet.find(pets_ids).each{|pet| owner.pets << pet } if !pets_ids.empty?
   owner.pets.create(name: pet_name) if !pet_name.empty?
   redirect "/owners/#{ owner.id}"
  end

  get '/owners/:id' do 
    @owner = Owner.find(params[:id])
    erb :'/owners/show'
  end

  
end