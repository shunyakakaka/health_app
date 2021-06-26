class BoardsController < ApplicationController

  def index
    @boards = Board.all
  end

  def new
    if Board.last == nil
      @board = Board.new
    else
      @board = Board.new(before_weight: Board.last.after_weight)
      if flash[:board]
        @board = Board.new(flash[:board])
      end
    end
  end

  def create
    board = Board.new(board_params)
    if Board.last == nil 
      board.before_weight = board.after_weight
    end
    if board.save
      flash[:notice] = "記録しました。"
      redirect_to board_path(board.id)
    else
      flash[:board] = board
      flash[:error_message] =  board.errors.full_messages
      redirect_to new_board_path
    end
  end

  def show
    @board = Board.find(params[:id])
  end

  def edit
    @board = Board.find(params[:id])
  end

  def update
    board = Board.find(params[:id])
    if board.update(board_params)
      flash[:notice] = "編集しました"
      redirect_to board_path(board.id)
    else
      flash[:error_message] = board.errors.full_messages
      redirect_to edit_board_path(board.id)
    end
  end

  private

  def board_params
    params.require(:board).permit(:before_weight, :after_weight, tag_ids: [])
  end
end
