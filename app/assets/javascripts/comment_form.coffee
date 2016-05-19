class @CommentForm
  constructor: (@$el, @options = {}) ->
    @bindEvents()

  bindEvents: ->
    @$el.on("ajax:success", (e, data, status, xhr) =>
      $.fancybox.close()
      @addComment(data)
    ).bind "ajax:error", (e, xhr, status, error) =>
      if xhr.status == 422
        @$el.html xhr.responseText

  addComment: (html) ->
    $comment = $(html)
    if @options.commentId
      $("@comment[data-comment-id=#{@options.commentId}]").replaceWith($comment)
    else
      if @options.parentId
        $parentComment = $("@comment[data-comment-id=#{@options.parentId}]")
        $node = $parentComment.parent()
        $replies = $node.find("@comment_replies")
        unless $replies.length
          $replies = $("<ul/>").addClass("b-comment-tree_nodes").addRole("comment_replies")
          $node.append($replies)
        $replies.append($comment)
      else
        $node = $("<li/>").addClass("b-comment-tree_node")
        $("@comment-tree").append($node)
        $node.append $comment

    top = $comment.position().top - $(window).height() / 2
    $("html, body").animate scrollTop: top, 400, "swing", ->
      $comment.css("background", "#cfd4da")
      setTimeout ->
        $comment.css("background", "#fff")
      , 2000
    new Comment($comment)
