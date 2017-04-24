class TestsController < ApplicationController
  def new
  end

   def create
    test = Test.new(test_params)
      if test.save
        redirect_to '/'
      else
        redirect_to '/'
      end
    end

 private

  def test_params
    params.require(:test).permit(:name)
  end


end
