class MazeController < ApplicationController
  include MazeHelper
  def index
    check_maze_params([params[:width], params[:height]])
    @maze_height = params[:width]
    @maze_width = params[:height]
    maze_generator = MazeGenarator.new(@maze_width, @maze_height)
    @maze_output = maze_generator.generate_map
  end

  private
  def check_maze_params(*params)
    params.each do |e|
      return unless e.is_a? Integer
    end
  end
end
