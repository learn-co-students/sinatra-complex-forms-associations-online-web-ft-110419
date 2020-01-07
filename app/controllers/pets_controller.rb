class PetsController < ApplicationController
  
  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index' 
  end
  
  get '/pets/new' do
    @owners = Owner.all
    erb :'/pets/new'
  end
  
  post '/pets' do
    pet = Pet.create(name: params[:name])
    if !params[:owner][:name].empty?
      pet.owner = Owner.create(name: params[:owner][:name])
    else
      pet.owner = Owner.find(params[:pet][:owner_id])
    end
    pet.save
    redirect to "/pets/#{pet.id}"
  end
  
  get '/pets/:id' do
    @pet = Pet.find(params[:id])
    @owner = Owner.all
    erb :'/pets/show'
  end
  
  get '/pets/:id/edit' do
    @pet = Pet.find(params[:id])
    @owners = Owner.all
    erb :'/pets/edit'
  end
  
  patch '/pets/:id' do
    pet = Pet.find(params[:id])
    pet.name = params[:pet_name] unless params[:pet_name].empty?
    if params[:owner_name].empty?
      pet.owner = Owner.find_by(name: params[:owner][:name])
    else
      pet.owner = Owner.create(name: params[:owner_name])
    end
    pet.save
    redirect to "pets/#{pet.id}"
  end
  
end
