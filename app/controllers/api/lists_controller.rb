class Api::ListsController < Api::ApplicationController
  before_action :set_list, only: [:show, :update, :destroy, :add_member]

  def index
    @lists = List.all
    render json: @lists
  end

  def show
    render json: @list
  end

  def create
    @list = List.new(list_params)
    if @list.save
      render json: @list, status: 201
    else
      render json: { errors: @list.errors }, status: 422
    end
  end

  def update
    if @list.update_attributes(list_params)
      render json: @list, status: 200
    else
      render json: { errors: @list.errors }, status: 422
    end
  end

  def destroy
    @list.destroy
    head 200
  end

  def add_member
    member = Member.find(params[:member_id])
    @list.members << member if member
    render json: { status: :ok }
  end

  private

  def set_list
    @list = List.find(params[:id])
  end

  def list_params
    ActionController::Parameters.new(JSON.parse(request.body.read)).
      permit(
        :name
      )
  end
end
