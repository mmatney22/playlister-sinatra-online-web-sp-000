require 'rack-flash'

class SongsController < ApplicationController
  enable :sessions
  use Rack::Flash

  get '/songs' do
    @songs = Song.all
    erb :'/songs/index'
  end

  get '/songs/new' do
    @genres = Genre.all
    erb :'/songs/new'
  end

  get '/songs/:slug' do
    @song = Song.find_by_slug(params[:slug])
    erb :'/songs/show'
  end

  post '/songs' do
    @song = Song.create(name: params[:Name])
    @song.artist = Artist.find_or_create_by(name: params[:artist])
    @song.genre_ids = params[:genre_ids]
    @song.save

    flash[:message] = "Successfully created song."
    redirect to "/songs/#{@song.slug}"
  end

  get '/songs/:slug/edit' do
    @song = Song.find_by_slug(params[:slug])
    erb :'/songs/edit'
  end

  patch '/songs/:slug' do
    @song = Song.find_by_slug(params[:slug])

    if params[:artist] != ""
      @artist = Artist.find_or_create_by(name: params[:artist])
      @song.artist = @artist
    end

    if params[:song] != ""
      @song.name = params[:song]
    end

    @genres = params[:genres]
    @song.genre_ids = @genres
    @song.save

    flash[:message] = "Successfully updated song."
    redirect to "songs/#{@song.slug}"
  end
end
