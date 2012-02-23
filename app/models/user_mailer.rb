class UserMailer < ActionMailer::Base

  def signup_notification(user)
    setup_email(user)
    @subject    += 'Por favor active su cuenta LibreCMS'
  
    @body[:url]  = 'Su registro en el sitio example.com está a punto de ser completado.
    Para que se complete el registro es necesario que visite "http://localhost:3000/activate/#{user.activation_code}"
    Reciba un cordial saludo.'
  end
  
  def activation(user)
    setup_email(user)
    @subject    += 'Su cuenta LibreCMS ha sido activada con exito'
    @body[:url]  = "http://localhost:3000/"
  end
  
  def forgot_password(user)
    setup_email(user)
    @subject    += 'Ha pedido cambiar la contraseña de su cuenta LibreCMS'
    @body[:url]  = "http://localhost:3000/reset_password/#{user.password_reset_code}"
  end

  def reset_password(user)
    setup_email(user)
    @subject    += 'La contraseña de su cuenta LibreCMS ha sido reseteada.'
  end

  protected
    def setup_email(user)
      @recipients  = "#{user.email}"
      @from        = "ADMINEMAIL"
      @subject     = "[YOURSITE] "
      @sent_on     = Time.now
      @body[:user] = user
    end

end
