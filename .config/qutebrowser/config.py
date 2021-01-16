import dracula.draw
import os

# Close tabs with q instead of d because I have an unstable middle finger c: config.unbind('q', mode='normal')
#config.unbind('d', mode='normal')
#config.bind('q', 'q')
# Use Searx, an open source privacy respecting metasearch engine by default
# Dark themes default
c.url.searchengines = {'DEFAULT':'https://searx.neocities.org/?q={}&oscar-style=logicodev-dark', 'sp':'https://www.startpage.com/do/search?q={}&prfe=e1b7bfc323f62c2f0a16735a739a301749d41e8058f6b43eec953990503fbfd7d7b7f836b6e4d3f5a4545511daa5b5401ffedb00154351b582cbbf5c8e68b65a8fb6b18b94f3b6f307070b936503f2341212', 'yt':'https://www.youtube.com/results?search_query={}'}
# Disable homepage
c.url.start_pages = ['file:///home/void/.home.html']
# Disable new tab page
c.url.default_page = 'about:blank'
# Use UTF-8
c.content.default_encoding = 'utf-8'
# Disable history
#c.content.private_browsing = True
#c.completion.web_history.exclude = ['<all_urls>']
#c.completion.web_history.max_items = 0
# Disable autoplay
c.content.autoplay = False
# Disable canvas
c.content.canvas_reading = False
# Send referrer from the same domain
c.content.headers.referer = 'same-domain'
# Use common UA
c.content.headers.user_agent = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/74.0.3729.131 Safari/537.36'
# Use common accept header
c.content.headers.accept_language = 'en-US,en;q=0.5'
c.content.headers.custom = {"accept": "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8"}
# Disable WebGL
c.content.webgl = False
# Disable WebRTC leaks (TODO Disable completely)
c.content.webrtc_ip_handling_policy = 'disable-non-proxied-udp'
# Block third party cookies
c.content.cookies.accept = 'no-unknown-3rdparty'
# Disable JavaScript
c.content.javascript.enabled = False
# Disable local storage
c.content.local_storage = False
config.bind('tsth', 'config-cycle -p -u {url:host} content.local_storage ;; reload')
config.bind('tstu', 'config-cycle -p -u {url} content.local_storage ;; reload')
# Editor command
c.editor.command = [os.environ['TERMCMD'], '--class', 'floating', '-e', 'vim', '-f', '{file}', '-c', 'normal {line}G{column}l'];
# Load modifications from browser (pariticularly for modified per site settings)
config.load_autoconfig()
# Hint links to (try to) load with MPV
config.bind('m', 'hint links spawn -d mpv "{hint-url}" ;; message-info "Choose to load in MPV"')
# Enable Dracula theme
dracula.draw.blood(c, {
    'spacing': {
        'vertical': 6,
        'horizontal': 8
    }
})
# TODO: Webpage dark mode
