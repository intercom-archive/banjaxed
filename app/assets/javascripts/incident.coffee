intervals = {}

$(document).on("page:change", ->
  $.each(intervals, (key, value) -> 
    clearInterval(value)
  )
  commentsEl = $("#comments-container")[0]
  Comments.initComments(commentsEl) if commentsEl
)

Comments =
  initComments: (el) ->
    self = this
    @el = $(el)
    @incidentId = @el.data('incident-id')
    return unless @incidentId
    @loadNewComments()
    intervals.commentPoll = setInterval ->
      self.loadNewComments()
    , 8000

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
      self.el.find('h4.text-danger').addClass('hidden')
    ).fail( ->
      self.el.find('h4.text-danger').removeClass('hidden')
    ).always( ->
      self.changeLoadingStatus(false)
    )

  appendComment: (comment) ->
    @el.find('#comments-list').append(@commentHTML(comment))

  commentHTML: (comment) ->
    commentTime = new Date(comment.created_at)
    timeString = commentTime.toLocaleString()
    """
      <p>
        #{comment.content}
        <small class="text-muted">
          (#{timeString})
        </small>
      </p>
    """

  changeLoadingStatus: (status) ->
    loader = @el.find('.spinner-wave')
    loader[(if status then 'removeClass' else 'addClass')]('ready')
