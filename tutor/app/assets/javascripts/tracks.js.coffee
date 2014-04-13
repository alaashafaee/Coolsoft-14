# [Create Track - Story 4.1]
# Create new Select List
# Parameters: 
#   value: The list to be created
# Author: Mussab ElDash
@change = (value) ->
    v = document.getElementById("second")
    v.innerHTML = value
    return

# [Create Track - Story 4.1]
# alert will be shown with value
# Parameters: 
#   value: The message to be alerted
# Author: Mussab ElDash
@show = (value) ->
    alert value
    return	

# [Create Track - Story 4.1]
# sends ajax post request to the server to get all 
# the problems of the track with id track_id
# then send the result to showProblems function
# that will put the result in a list
# Parameters: 
#   track_id: The id of the track of the requested problems
# Author: Mussab ElDash
@getProblems = (track_id) ->
    $.ajax
        type: "POST"
        url: "/tracks/" + track_id + "/getProblems"
        datatype: "json"
        success: (data) ->
            showProblems data
            return
    return

# [Create Track - Story 4.1]
# show the recieved set of problems in the select list
# Parameters: 
#   datas: List of problems to be shown
# Author: Mussab ElDash
showProblems = (datas) ->
    inner = "<input name='Problem[id][]' type='hidden' value='' />
                <select id='ProblemsSel' multiple='multiple' name='Problem[id][]' 
                onchange='' size='15' style='width:250px;align='center'>"
    for data in datas
        opt = "<option value='" + data.id + "'>" + data.title + "</option>"
        inner += opt
    inner += "</select>"
    document.getElementById("second").innerHTML = inner
    return

# [Create Track - Story 4.1]
# triggers the visibilty of the create track form
# Author: Mussab ElDash
@newTrack = ->
    create = document.getElementById("create_track")
    if create.hidden is true
        create.hidden = false
    else
        create.hidden = true
    return

# [Create Track - Story 4.1]
# Returns: The id of the selected track
# Author: Mussab ElDash
getSelectedTrackId = ->
    tracks = document.getElementById("tracksSel")
    tracks.options[tracks.selectedIndex].value

# [Create Track - Story 4.1]
# Returns: The id of the selected problem
# Author: Mussab ElDash
getSelectedProblemId = ->
    problems = document.getElementById("problemsSel")
    problems.options[problems.selectedIndex].value

# [Create Track - Story 4.1]
# this function is called when the page finishes loading
# selects the first track in the track list
# and focuses on the track list
# Author: Mussab ElDash
jQuery ->
    getProblems getSelectedTrackId()
    document.getElementById("tracksSel").focus()
    return