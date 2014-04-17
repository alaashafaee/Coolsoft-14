class SystemReminders < ActionMailer::Base
  default from: "from@example.com"
  def reminder_email(current_student)
    @user = current_student
    @url  = 'http://localhost:3000'
    mail(to: @user.email, subject: 'We miss you at our Awesome Tutors Website')
  end
end
