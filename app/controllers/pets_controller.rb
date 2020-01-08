class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index' 
  end

  get '/pets/new' do 
    erb :'/pets/new'
  end

  post '/pets' do
    if params[:owner][:name].empty? #if no name was placed #choosing from previous owners
      @owner = Owner.find_by_id(params[:pet][:owner_id])
      @pet = Pet.create(name: params[:pet][:name])
      @owner.pets << @pet
    
    else #If a name was placed #new owner being created # new owner works well
      @owner = Owner.create(name: params[:owner][:name])
      @pet = Pet.create(name: params[:pet][:name])
      @owner.pets << @pet
    end
    redirect to "/pets/#{@pet.id}"
  end
  
  get '/pets/:id' do
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end
  
  get '/pets/:id/edit' do
    @pet = Pet.find(params[:id])
    erb :'/pets/edit'
  end

  post '/pets/:id' do 
    @pet = Pet.find_by_id(params[:id])
    @owner = Owner.find_by_id(params[:id])
    @pet.update(params[:pet])
    @owner.update(params[:owner])
    redirect to "pets/#{@pet.id}"
  end
end