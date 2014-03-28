@change = (value) ->
    v = document.getElementById("second")
    v.innerHTML = value
    return

@show = (value) ->
    alert value
    return	

@getProblems = (track_id) ->
    $.ajax
        type: "POST"
        url: "/tracks/" + track_id + "/getProblems"
        datatype: "json"
        success: (data) ->
            showProblems data
            return
    return

showProblems = (datas) ->
    inner = "<input name='Problem[id][]' type='hidden' value='' /><select id='ProblemsSel' multiple='multiple' name='Problem[id][]' onchange='' size='15' style='width:250px;align='center'>"
    for data in datas
        opt = "<option value='" + data.id + "'>" + data.title + "</option>"
        inner += opt
    inner += "</select>"
    document.getElementById("second").innerHTML = inner
    return

@newTrack = ->
    create = document.getElementById("create_track")
    if create.hidden is true
        create.hidden = false
    else
        create.hidden = true
    return

getSelectedTrackId = ->
    tracks = document.getElementById("tracksSel")
    tracks.options[tracks.selectedIndex].value

getSelectedProblemId = ->
    problems = document.getElementById("problemsSel")
    problems.options[problems.selectedIndex].value

jQuery ->
    getProblems getSelectedTrackId()
    document.getElementById("tracksSel").focus()
    return