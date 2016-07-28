class GameLobbiesController < ApplicationController
  layout 'lobbies'
  def playerIndex
    @user = User.all
  end 
  def GameOne
  end

  def GameTwo
  end

  def GameThree
  end

  def GameFour
  end
end
