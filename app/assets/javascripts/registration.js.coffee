# TODO: Validate dob field
# Disable sport if dob made blank
# Style disable field

Registration = 
  populateSports: (sports) ->
    options = "<option></option>"
    for sport in sports
      options += '<option value="' + sport[0] + '">' + sport[1] + '</option>'
    $("select[name='sport']").find('option').remove().end().append($(options))
    $("select[name='sport']").attr("disabled", false)

  getSports: (dob) ->
    $.getJSON("/sports", "birth_date=" + dob, Registration.populateSports)

$(document).ready ->
  $("#registration_athlete_dob").change(-> Registration.getSports($(this).val()))

  if ! $.trim($("#registration_athlete_dob").val())
    $("select[name='sport']").attr("disabled", "disabled")
