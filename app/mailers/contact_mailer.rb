class ContactMailer < ApplicationMailer
  def send_mail(mail_title, mail_content, group_users)#引数 groupscontrollerから呼び出されて、値を受け取る
   @mail_title = mail_title
   @mail_content = mail_content
   mail bcc: group_users.pluck(:email), subject: mail_title
  end
end
