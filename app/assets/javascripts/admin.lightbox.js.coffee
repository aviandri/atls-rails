window.admin ||= {}
$.extend window.admin,

  lightbox:
    show: (options) ->
      options       = {}  unless options
      buttonDone    = options.buttonDone or "Done"
      buttonCancel  = options.buttonCancel or "Cancel"
      focus         = options.focus or "input"

      $("body").append "<div id='modal_shadow'></div>"  unless $("div#modal_shadow")[0]

      $("body").append "<div id='admin-lightbox'></div>"  unless $("div#admin-lightbox")[0]

      $("div#admin-lightbox").html "<div id='content'>" + options.html + "</div><div id='buttons'></div>"

      $("div#admin-lightbox div#buttons").append "<button onclick='admin.lightbox.do_done(); return false;'>" + buttonDone + "</button>"
      $("div#admin-lightbox div#buttons").append "<button onclick='admin.lightbox.do_cancel(); return false;'>" + buttonCancel + "</button>"

      $("div#admin-lightbox").prepend "<div id='title'>" + options.title + "</div>"  if options.title

      $("div#modal_shadow").show()
      $("div#admin-lightbox").show()

      $($("div#admin-lightbox " + focus)[0]).focus()

      admin.lightbox

    callback_done: null
    done: (callback) ->
      admin.lightbox.callback_done = callback
      admin.lightbox
    do_done: ->
      try
        admin.lightbox.callback_done()
      admin.lightbox.hide()
      false

    callback_cancel: null
    cancel: (callback) ->
      admin.lightbox.callback_cancel = callback
      admin.lightbox
    do_cancel: ->
      try
        admin.lightbox.callback_cancel()
      admin.lightbox.hide()
      false

    hide: ->
      $("div#modal_shadow").hide()
      $("div#admin-lightbox").hide()
      admin.lightbox
