class Api::MembersController < Api::ApplicationController
  before_action :set_member, only: [:show, :update, :destroy]

  def index
    @members = Member.all
    render json: @members
  end

  def show
    render json: @member
  end

  def create
    @member = Member.new(member_params)
    if @member.save
      render json: @member, status: 201
    else
      render json: @member, status: 422
    end
  end

  def update
    if @member.update_attributes(member_params)
      render json: @member, status: 200
    else
      render json: @member, status: 422
    end
  end

  def destroy
    @member.destroy
    head 200
  end

  private

  def set_member
    @member = Member.find(params[:id])
  end

  def member_params
    ActionController::Parameters.new(JSON.parse(request.body.read)).
      permit(
        :name,
        :email,
        :email_sub
      )
  end
end
