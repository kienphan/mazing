module MazeHelper
  class MazeGenarator

    attr_accessor :width, :height

    N, S, E, W = 1, 2, 4, 8
    DX         = { E => 1, W => -1, N =>  0, S => 0 }
    DY         = { E => 0, W =>  0, N => -1, S => 1 }
    OPPOSITE   = { E => W, W =>  E, N =>  S, S => N }

    def initialize(width, height)
      @width = width.to_i
      @height = height.to_i
    end

    def generate_map
      maze_output = ""
      seed   = rand(0xFFFF_FFFF)
      srand(seed)

      grid = Array.new(@height) { Array.new(@width, 0) }

      carve_passages_from(0, 0, grid)

      puts "_" * (@width * 2 - 1)
      maze_output.concat("_" * (@width * 2) + "\n")
      @height.times do |y|
        maze_output.concat "|"
        @width.times do |x|
          maze_output.concat((grid[y][x] & S != 0) ? " " : "_")
          if grid[y][x] & E != 0
            maze_output.concat(((grid[y][x] | grid[y][x+1]) & S != 0) ? " " : "_")
          else
            maze_output.concat("|")
          end
        end
        maze_output.concat("\n")
      end
      maze_output
    end

    def carve_passages_from(cx, cy, grid)
      directions = [N, S, E, W].sort_by{rand}

      directions.each do |direction|
        nx, ny = cx + DX[direction], cy + DY[direction]

        if ny.between?(0, grid.length-1) && nx.between?(0, grid[ny].length-1) && grid[ny][nx] == 0
          grid[cy][cx] |= direction
          grid[ny][nx] |= OPPOSITE[direction]
          carve_passages_from(nx, ny, grid)
        end
      end
    end
  end
end
