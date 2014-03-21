$(document).ready ->
	$('.datatable').dataTable()


	$('form').find('.user-search').userSearch()

	return




$.fn.extend
	userSearch: () ->
		$(this).each (i, el) ->
			new $.userSearch(el)
 
$.userSearch = (el)->
	this.init(el)

$.userSearch.prototype = 
	init: (el) ->
		this.el = el
		this.$el = $(el)
		this.result = $('<ul>').addClass '.user-search-results'
		this.searchBox = $('<input>').addClass '.user-search-box'

		this.$el.after(this.result) #Add the Results container.
		this.$el.after(this.searchBox) #Add the Search Box.
		this.$el.hide() #hide the Select element

		this.multiple = this.el.tagName.toUpperCase() == 'SELECT'
		this.selectedList = []
		this.loadSelected()

		this.hookEvents()

		return

	hookEvents: ->
		$this = this
		timeout = null

		#Event for the entered search word.
		$this.searchBox.on 'keyup', ->
			clearTimeout(timeout)
			data = $(this).val()
			if data == ''
				$this.result.empty()
			else
				timeout = setTimeout((-> $this.search(data)), 500)
			return

		#Event for clicked search result
		$this.result.on 'click', 'li', ->
				$user = $(this)
				name = $user.text()
				id = $user.attr('data-value')
				if $this.multiple
					$this.$el.append($this.option(id, name))
				else
					alert($this.el.tagName)

				$this.selectedList.push(id)
				$user.addClass('selected')
			return

	search: (data)->
		$this = this
		$.ajax
			url: '/users/search'
			data: 'q='+data
			success: (res)->
				$this.result.html(res)
				$this.select()

		return

	select: ->
		$this = this
		this.result.find('.user').each ->
			id = $(this).attr('data-value')
			if $.inArray(id, $this.selectedList) != -1
				$(this).addClass('selected')

	loadSelected: ->
		$this = this 
		$this.$el.find('option[selected="selected"]').each ->
			id = $(this).attr('value')
			$this.selectedList.push(id)

	option: (value, name)->
		return '<option value='+value+' selected="selected">'+name+'</option>'




