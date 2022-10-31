# frozen_string_literal: true

##
# Controller Class for handling endpoints to "/reactions"
class ReactionsController < ApplicationController
  
  # Just one endpoint required, records a like and returns user to the articles index.
  # PATCH/PUT /reactions/1 or /reactions/1.json
  def like
    @reaction = Reaction.find_by(article_id: params['id'])
    @reaction.by_user = true
    @reaction.likes += 1
    respond_to do |format|
      if @reaction.save
        format.html { redirect_to articles_path }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end
end
