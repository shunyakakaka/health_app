class BoardsController < ApplicationController

  def index
    @boards = current_user.boards
  end

  def new
    if current_user.boards.last == nil
      @board = current_user.boards.new
    else
      @board = current_user.boards.new(before_weight: current_user.boards.last.after_weight)
      if flash[:board]
        @board = current_user.boards.new(flash[:board])
      end
    end
  end

  def create
    @board = current_user.boards.new(board_params)
    if current_user.boards.last.before_weight == nil 
      @board.before_weight = @board.after_weight
    end
    if @board.save
      flash[:notice] = "記録しました。"
      redirect_to board_path(@board.id)
    else
      if @board.before_weight == ""
        board = Board.find(Board.ids.length)
        @board.before_weight = board.after_weight
        flash[:board] = @board
        flash[:error_message] =  @board.errors.full_messages
        redirect_to new_board_path
      else
        flash[:board] = @board
        flash[:error_message] =  @board.errors.full_messages
        redirect_to new_board_path
      end
    end
  end

  def show
    @board = current_user.boards.find(params[:id])
  end

  def edit
    @board = current_user.boards.find(params[:id])
  end

  def update
    board = current_user.boards.find(params[:id])
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
