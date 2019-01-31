class PromotionsController < ApplicationController
  before_action :authenticate_user!
  before_action :verify_author, only: %i( approve )

  def index
    @promotions = Promotion.all
  end

  def new
    @promotion = Promotion.new
  end

  def create
    @promotion = Promotion.new promotion_params
    @promotion.user = current_user
    if @promotion.save
      redirect_to @promotion
    else
      render :new
    end
  end

  def show
    @promotion = Promotion.find(params[:id])
  end

  def approve
    @promotion = Promotion.find(params[:id])
    @promotion_approval = PromotionApproval.create(promotion: @promotion,
                                                   user: current_user)
    redirect_to @promotion, notice: 'Promoção aprovada com sucesso!'
  end

  def generate_coupons
    @promotion = Promotion.find(params[:id])
    @promotion.generate_coupons(current_user)
    redirect_to @promotion, notice: 'Cupons emitidos com sucesso!'
  end

  private

  def verify_author
    @promotion = Promotion.find(params[:id])
    if @promotion.author?(current_user)
      redirect_to root_path, notice: 'Você não pode aprovar esta promoção'
    end
  end

  def promotion_params
    params.require(:promotion)
          .permit(:title, :description, :discount, :start_at, :prefix,
                  :quantity, :duration, :user_id)
  end
end
