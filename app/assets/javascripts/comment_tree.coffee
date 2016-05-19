class @CommentTree
  constructor: (@$el) ->
    @$el.find("@comment").each ->
      new Comment $(this)

    @bindEvents()

  bindEvents: ->
    @$el.find("@add_comment").click (e) ->
      e.preventDefault()
      articleId = $(this).data("articleId")
      $.fancybox
        href: "/articles/#{articleId}/comments/new",
        type: "ajax"
        afterShow: =>
          new CommentForm($("@comment_form"))

