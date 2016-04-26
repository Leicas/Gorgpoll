class VoteMailer < ApplicationMailer
 default from: 'notifications@weill-duflos.fr'

 def vote_email(mail, token, clef)
  @email = mail
  @token = token
  @clef = clef
  mail(to: mail, subject: 'Invitation au vote')
 end

end
