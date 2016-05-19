class @Comment
  constructor: (@$el) ->
    @articleId = @$el.data("articleId")
    @commentId = @$el.data("commentId")

    @bindEvents()

  bindEvents: ->
    @$el.find("@comment_reply").click =>
      $.fancybox
        href: "/articles/#{@articleId}/comments/new?parent_id=#{@commentId}",
        type: "ajax"
        afterShow: =>
          new CommentForm($("@comment_form"), parentId: @commentId)

    @$el.find("@comment_edit").click (e) =>
      e.preventDefault()

      $.fancybox
        href: "/articles/#{@articleId}/comments/#{@commentId}/edit",
        type: "ajax"
        afterShow: =>
          new CommentForm($("@comment_form"), commentId: @commentId)

    @$el.find("@comment_remove").on "ajax:success", =>
      @$el.animate height: 0, 600, "swing", =>
        @$el.parent().remove()
