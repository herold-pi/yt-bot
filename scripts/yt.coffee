spawn = require("child_process").spawn

module.exports = (robot) ->
  robot.respond /(.*)/i, (msg) ->
    link = msg.match[1]
    yt = spawn("youtube-dl", ["-x", "--audio-format", "mp3", "--audio-quality", "0", link])
    yt.stdout.on 'data', (data) ->
      console.log "#{data}"
    yt.stderr.on 'data', (data) ->
      console.error "#{data}"
    yt.on 'close', (code) ->
      console.log code
      if code is 0
        msg.send "Hey, I've downloaded #{link}"
      else
        msg.send "I have a problem with #{link}"
