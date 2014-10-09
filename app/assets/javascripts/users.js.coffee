passwordConfirmation = ->
  $pass = $('.new-user-pass')
  $passConf = $('.new-user-pass-conf')
  $passError = $('.password-error')
  if $pass
    $passConf.keyup ->
      if $pass.val() != $passConf.val()
        $passError.css('color', 'red').text('Password and Password Confirmation do not match')
        $passConf.css
          'color': 'white'
          'background-color': 'red'
      else
        $passError.text('')
        $passConf.css
          'background-color': 'white'
          'color': 'black'

emailValidation = ->
  $emailForm = $('.new-user-email')
  $emailValid = $('.email-valid')
  if $emailForm
    $emailForm.keyup ->
      emailRegEx = /[^@]+@fedscoop.com/
      if $emailForm.val().match emailRegEx
        $emailValid.css 'color', 'green'
      else
        $emailValid.css 'color', 'red'


$ ->
  passwordConfirmation()
  emailValidation()
