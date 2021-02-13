class ContactsController < ApplicationController
  before_action :login_required

  def new
    @contact = Contact.new
  end

  def confirm
    @contact = Contact.new(contact_params)
    if @contact.save
      render "confirm"
    else
      render action: :new    
    end
  end

  def complete
    @contact = Contact.new(contact_params)
    if params[:back]
      render action: :new
    else
      ContactMailer.received_email(@contact).deliver_now   
    end  
  end

  private

  def contact_params
    params.require(:contact).permit(:name, :email, :content)
  end

  def login_required 
    redirect_to login_path unless current_user
  end
end
