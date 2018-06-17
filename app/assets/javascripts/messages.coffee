$(document).ready =>
      username = ''

      $('.sidebar-form').keyup (event) ->
        if event.keyCode == 13 and !event.shiftKey
          $('.username').removeClass('d-none')
          $('.sidebar-form').addClass('d-none')
          $('#message').removeAttr("disabled")
          $('#message').focus()
        return

      $('#chat-form').on 'ajax:success', (data) ->
        data.preventDefault()
        console.log('sss')
        $('#chat-form')[0].reset()
        
        updateChat data.detail[0]
        return

      updateChat = (data) ->
        $('.chat-box').append """
          <div class="col-12">
            <div class="chat bg-secondary d-inline-block text-left text-white mb-2">
              <div class="chat-bubble">
                <p class="m-0 mt-2 chat-message">#{data.message}</p>
              </div>
            </div>
          </div>
        """
        return