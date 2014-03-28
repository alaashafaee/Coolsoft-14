@change = (value) ->
    v = document.getElementById("second")
    v.innerHTML = value
    return

# alert will be shown with value
@show = (value) ->
    alert value
    return	

# sends ajax post request to the server to get all the problems of the track with id track_id
# then send the result to showProblems function that will put the result in a list
@getProblems = (track_id) ->
    $.ajax
        type: "POST"
        url: "/tracks/" + track_id + "/getProblems"
        datatype: "json"
        success: (data) ->
            showProblems data
            return
    return
# show the recieved set of problems in the select list
showProblems = (datas) ->
    inner = "<input name='Problem[id][]' type='hidden' value='' /><select id='ProblemsSel' multiple='multiple' name='Problem[id][]' onchange='' size='15' style='width:250px;align='center'>"
    for data in datas
        opt = "<option value='" + data.id + "'>" + data.title + "</option>"
        inner += opt
    inner += "</select>"
    document.getElementById("second").innerHTML = inner
    return

# triggers the visibilty of the create track form
@newTrack = ->
    create = document.getElementById("create_track")
    if create.hidden is true
        create.hidden = false
    else
        create.hidden = true
    return

# returns the id of the selected track
getSelectedTrackId = ->
    tracks = document.getElementById("tracksSel")
    tracks.options[tracks.selectedIndex].value

# returns the id of the selected problem
getSelectedProblemId = ->
    problems = document.getElementById("problemsSel")
    problems.options[problems.selectedIndex].value

# this function is called when the page finishes loading
# selects the first track in the track list
# and focuses on the track list
jQuery ->
    getProblems getSelectedTrackId()
    document.getElementById("tracksSel").focus()
    return