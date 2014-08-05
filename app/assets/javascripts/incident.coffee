commentsList = null

$(document).on("page:change", ->
  commentsList.leave() if commentsList
  commentsEl = $("#comments-container")[0]
  if commentsEl
    commentsList = new CommentsList(commentsEl)
  else
    commentsList = null

  $('#incident-status').change ->
    $(this).closest('form').submit()
)

class CommentsList
  constructor: (el) ->
    self = this
    @el = $(el)
    @incidentId = @el.data('incident-id')
    return unless @incidentId
    @loadNewComments()
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
      

  leave: ->
    clearInterval(@commentPollInterval)

  loadNewComments: ->
    self = this
    self.changeLoadingStatus(true)
    params = {}
    params.after_id = @lastId if @lastId
    $.getJSON("/incidents/#{@incidentId}/comments.json", params, (comments) ->
      lastComment = comments[comments.length - 1]
      self.lastId = lastComment.id if lastComment
      $.each(comments, ->
        self.appendComment(@)
      )
      if comments.length
        $('.go-to-add-comment').removeClass('hidden')
      
      self.changeErrorStatus(false)
    ).fail( ->
      self.changeErrorStatus(true)
    ).always( ->
      self.changeLoadingStatus(false)
    )

  appendComment: (comment) ->
    @el.find('#comments-list').append(@commentHTML(comment))

  commentHTML: (comment) ->
    commentTime = new Date(comment.created_at)
    timeString = commentTime.toLocaleString()
    """
      <div class="panel panel-default">
        <div class="panel-heading"><small>
          #{comment.user.name}
          <span class="pull-right text-muted">#{timeString}</span>
        </small></div>
        <div class="panel-body">#{comment.content}</div>
      </div>
    """

  changeLoadingStatus: (status) ->
    loader = @el.find('.spinner-wave')
    loader[(if status then 'removeClass' else 'addClass')]('ready')

  changeErrorStatus: (status) ->
    errorMessage = @el.find('h4.text-danger')
    errorMessage[(if status then 'removeClass' else 'addClass')]('hidden')

