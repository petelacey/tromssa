# TODO: Validate dob field
# Disable sport if dob made blank
# Style disable field

Registration = 
  populatePrograms: (programs) ->
    options = ""
    for sport, descriptions of programs
      console.log(sport)
      console.log(descriptions)
      options += '<optgroup label="' + sport + '">'
      for value, desc of descriptions
        options += '<option value="' + value + '">' + desc + '</option>'

    program_element = $("select[name='program']")
    program_element.find('optgroup').remove().end().append($(options))

    if options == ""
      program_element.attr("disabled", true)
    else
      program_element.attr("disabled", false)

  getPrograms: (dob) ->
    if $("#registration_athlete_dob").parsley('validate')
      $.getJSON("/programs", "birth_date=" + dob, Registration.populatePrograms)
    else
      $("select[name='program']").attr("disabled", "disabled")

$(document).ready ->
  $("#new_registration").attr("novalidate","novalidate").parsley(
    successClass: 'has-success',
    errorClass: 'has-error',
    errors: {
      classHandler: (el) ->
        return jQuery(el).closest('.form-group')
    }
  )
  $("#registration_athlete_dob").change(-> Registration.getPrograms($(this).val()))

  if ! $.trim($("#registration_athlete_dob").val())
    $("select[name='program']").attr("disabled", "disabled")
