# frozen_string_literal: true

class CatsController < ApplicationController
  def index
    result = Cat::Filter.call

    render('cats/index', locals: { cats: result[:cats] })
  end

  def new
    render('cats/new', locals: { cat: Cat::Form.new, errors: nil })
  end

  def show
    Cat::Find.call(id: params[:id])
      .on_success { |result| render('cats/show', locals: { cat: result[:cat] }) }
      .on_failure(:not_found) { redirect_to(cats_path, notice: 'Cat not found!') }
  end

  def edit
    Cat::Find.call(id: params[:id])
      .on_success { |result| render('cats/edit', locals: { cat: result[:cat], errors: nil }) }
      .on_failure(:not_found) { redirect_to(cats_path, notice: 'Cat not found!') }
  end

  def create
    Cat::Create.call(**cat_params)
      .on_success { |result| handle_create(result[:cat]) }
      .on_failure(:invalid_params) do |result|
        render(
          turbo_stream: turbo_stream.update('cat-errors', partial: 'cats/form/errors', locals: { errors: result[:errors]})
        )
      end
  end

  def update
    Cat::Update.call(**cat_params.merge({ id: params[:id] }))
      .on_success { |result| render('cats/show', locals: { cat: result[:cat] }, status: :see_other) }
      .on_failure(:not_found) { redirect_to(cats_path, notice: 'Cat not found!') }
      .on_failure(:invalid_params) do |result|
        render(
          turbo_stream: turbo_stream.update('cat-errors', partial: 'cats/form/errors', locals: { errors: result[:errors]})
        )
      end
  end

  def destroy
    Cat::Destroy.call(id: params[:id])
      .on_success { redirect_to(cats_path, notice: 'Cat was successfully destroyed.') }
      .on_failure(:not_found) { redirect_to(cats_path, notice: 'Cat not found!') }
  end

  private

  def cat_params
    params.require(:cat).permit(:name, :breed, :favorite_quote)
  end

  def handle_create(cat)
    Turbo::StreamsChannel.broadcast_prepend_to('cat-creation', target: 'cats', partial: 'cats/cat', locals: { cat: })
    render('cats/show', locals: { cat: }, status: :see_other)
  end
end
