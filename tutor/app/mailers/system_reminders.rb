class SystemReminders < ActionMailer::Base
  default from: "from@example.com"
  def welcome_email(current_student)
    @user = current_student
    @url  = 'http://localhost:3000'
    mail(to: @user.email, subject: 'Welcome to our Awesome Tutors Website')
  end
end
