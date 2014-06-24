# [Post to Facebook - Story 5.1]
# Opens popup window for the facebook popup
# Parameters:
# 	url: url to open in popup window
# 	popName: name of popup window
# Returns: none
# Author: Amir George

@openBackWindow = (url, popName) ->
	popupWindow = window.open(url, popName, "scrollbars=1,height=1,width=1")
	if $.browser and $.browser.msie
		popupWindow.blur()
		window.focus()
	else
		blurPopunder()
	return

# [Post to Facebook - Story 5.1]
# Helper for openBackWindow
# Parameters: none
# Returns: none
# Author: Amir George

blurPopunder = ->
	winBlankPopup = window.open("about:blank")
	if winBlankPopup
		winBlankPopup.focus()
		winBlankPopup.close()
	return
