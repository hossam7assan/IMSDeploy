class UserNotifierMailer < ApplicationMailer
   default from: 'notifications@example.com'
     # layout "mailer"
   def welcome_email(student)
      @student = student
      @url  = 'http://www.gmail.com'
      mail(to: @student.email, subject: 'Welcome to ITI')
   end
end