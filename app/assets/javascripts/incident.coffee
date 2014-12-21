commentsList = null
incidentsList = null

$(document).on("page:change", ->
  commentsList.leave() if commentsList
  incidentsList.leave() if incidentsList
  commentsEl = $("#comments-container")[0]
  incidentsEl = $(".incidents-table")[0]

  if commentsEl
    commentsList = new CommentsList(commentsEl)
  else
    commentsList = null

  if incidentsEl
    incidentsList = new IncidentsList(incidentsEl)
  else
    incidentsList = null

  $('#incident-status').change ->
    $(this).closest('form').submit()
)

class IncidentsList
  constructor: (el) ->
    self = this
    @incidentPollInterval = setInterval ->
      self.loadNewIncidents()
    , 8000

  leave: ->
    clearInterval(@incidentPollInterval)

  loadNewIncidents: ->
    $.get("./incidents.js?recent");

class CommentsList
  constructor: (el) ->
    self = this
    @el = $(el)
    @incidentId = @el.data('incident-id')
    return unless @incidentId

    @commentPollInterval = setInterval ->
      self.loadNewComments()
    , 8000

    newCommentForm = @el.find("#new_comment")

    newCommentForm.on("ajax:success", ->
      self.loadNewComments()
      newCommentForm.find('textarea').val('')
    ).on "ajax:error", ->
      self.changeErrorStatus(true)

    $('.go-to-add-comment').click ->
      body = $('body')
      body.scrollTop(body.height())
      self.el.find('textarea').focus()

    $("body").on("click", ".go-to-edit-comment", ->
      commentPanel = $(this).closest('.panel')
      commentBody = $('.panel-body', commentPanel)
      commentId = commentPanel.attr('data-comment-id')
      $.get("#{self.incidentId}/comments/#{commentId}/edit", (data) ->
        commentBody.html(data)
        $("#edit_comment_" + commentId).on("ajax:success", (event, result)->
          commentPanel.html($(result).children()))))

  leave: ->
    clearInterval(@commentPollInterval)

  lastCommentId: ->
    $('#comments-list').children().last().data('comment-id')

  loadNewComments: ->
    self = this
    self.changeLoadingStatus(true)
    params = { after_id: @lastCommentId() }
    $.get("/incidents/#{@incidentId}/comments.js", params, (data) ->
      self.changeErrorStatus(false)
      self.updateCommentButtonVisibility()
    ).fail( ->
      self.changeErrorStatus(true)
    ).always( ->
      self.changeLoadingStatus(false)
    )

  changeLoadingStatus: (status) ->
    loader = @el.find('.spinner-wave')
    loader[(if status then 'removeClass' else 'addClass')]('ready')

  changeErrorStatus: (status) ->
    errorMessage = @el.find('h4.text-danger')
    errorMessage[(if status then 'removeClass' else 'addClass')]('hidden')

  updateCommentButtonVisibility: ->
    if $('#comments-list').children().length
      $('.go-to-add-comment').removeClass('hidden')
