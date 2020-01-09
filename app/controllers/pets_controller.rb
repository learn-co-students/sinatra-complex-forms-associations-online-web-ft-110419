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
    @pet = Pet.create(params[:pet])
    if !@pet.owner 
      @pet.owner = Owner.find_or_create_by(name: params[:owner][:name])
      @pet.save
    end
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id' do 
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  get '/pets/:id/edit' do 
    @owners = Owner.all
    @pet = Pet.find_by_id(params[:id])
    if @pet == nil
      redirect '/pets'
    else
      erb :'pets/edit'
    end
  end

  patch '/pets/:id' do 
    @pet = Pet.find(params[:id])
    @pet.update(params[:pet])
    if !params[:owner][:name].empty?
      @pet.owner = Owner.find_or_create_by(name: params[:owner][:name])
      @pet.save
    end
    redirect to "pets/#{@pet.id}"
  end
end