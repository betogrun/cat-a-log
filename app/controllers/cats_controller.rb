# frozen_string_literal: true

class CatsController < ApplicationController
  def index
    result = Cat::Filter.call

    render('cats/index', locals: { cats: result[:cats] })
  end

  def show
    Cat::Find.call(id: params[:id])
      .on_success { |result| render('cats/show', locals: { cat: result[:cat] }) }
      .on_failure(:not_found) { redirect_to(cats_path, notice: t('cat.not_found')) }
  end

  def new
    render('cats/new', locals: { cat: Cat::Form.new, errors: nil })
  end

  def edit
    Cat::Find.call(id: params[:id])
      .on_success { |result| render('cats/edit', locals: { cat: result[:cat], errors: nil }) }
      .on_failure(:not_found) { redirect_to(cats_path, notice: t('cat.not_found')) }
  end

  def create
    Cat::Create.call(**cat_params)
      .on_success { |result| render('cats/show', locals: { cat: result[:cat] }) }
      .on_failure(:invalid_params) do |result|
      render('cats/new', locals: { errors: result[:errors], cat: Cat::Form.new(cat_params) })
    end
  end

  def update
    Cat::Update.call(**cat_params, **{ id: params[:id]})
      .on_success { |result| render('cats/show', locals: { cat: result[:cat] }) }
      .on_failure(:not_found) { redirect_to(cats_path, notice: t('cat.not_found')) }
      .on_failure(:invalid_params) do |result|
      render('cats/edit', locals: { errors: result[:errors], cat: Cat::Form.new(cat_params) })
    end
  end

  def destroy
    Cat::Destroy.call(id: params[:id])
      .on_success { redirect_to(cats_path, notice: t('cat.destroyed')) }
      .on_failure(:not_found) { redirect_to(cats_path, notice: t('cat.not_found')) }
  end

  private

  def cat_params
    params.require(:cat).permit(:name, :breed, :favorite_quote)
  end
end
