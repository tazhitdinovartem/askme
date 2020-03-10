class HashtagsController < ApplicationController
  def show
    @hashtag = Hashtag.friendly.find(params[:id])
  end
end