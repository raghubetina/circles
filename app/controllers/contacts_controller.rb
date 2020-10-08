class ContactsController < ApplicationController
  before_action :current_user_must_be_contact_user, only: %i[edit update destroy]

  before_action :set_contact, only: %i[show edit update destroy]

  def index
    @q = current_user.contacts.ransack(params[:q])
    @contacts = @q.result(distinct: true).includes(:user).page(params[:page]).per(10)
  end

  def show; end

  def new
    @contact = Contact.new
  end

  def edit; end

  def create
    @contact = Contact.new(contact_params)

    if @contact.save
      message = "Contact was successfully created."
      if Rails.application.routes.recognize_path(request.referer)[:controller] != Rails.application.routes.recognize_path(request.path)[:controller]
        redirect_back fallback_location: request.referer, notice: message
      else
        redirect_to @contact, notice: message
      end
    else
      render :new
    end
  end

  def update
    if @contact.update(contact_params)
      redirect_to @contact, notice: "Contact was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @contact.destroy
    message = "Contact was successfully deleted."
    if Rails.application.routes.recognize_path(request.referer)[:controller] != Rails.application.routes.recognize_path(request.path)[:controller]
      redirect_back fallback_location: request.referer, notice: message
    else
      redirect_to contacts_url, notice: message
    end
  end

  private

  def current_user_must_be_contact_user
    set_contact
    unless current_user == @contact.user
      redirect_back fallback_location: root_path, alert: "You are not authorized for that."
    end
  end

  def set_contact
    @contact = Contact.find(params[:id])
  end

  def contact_params
    params.require(:contact).permit(:user_id, :name, :email, :phone_number)
  end
end
