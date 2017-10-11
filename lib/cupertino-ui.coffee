version = atom.getVersion()
if parseFloat(version) > 1.18
  require('electron').remote.getCurrentWindow(webPreferences: experimentalFeatures: true).setVibrancy 'sidebar'
  document.body.classList.add 'cupertino-vibrancy'

#######

addClass = (el, klass) ->
  return unless el
  el.className = "#{el.className} #{klass}"

removeClass = (el, klass) ->
  return unless el
  classes = el.className.split(' ')
  index = classes.indexOf(klass)
  classes.splice(index, 1) if index >= 0
  el.className = classes.join(' ')

module.exports =
  config:
    sidebarSize:
      title: 'Sidebar icon size'
      type: 'string'
      default: 'medium'
      enum: [
        {value: 'small', description: 'Small'}
        {value: 'medium', description: 'Medium'}
        {value: 'large', description: 'Large'}
      ]
    styleLineNumbers:
      title: 'Style line numbers in editor'
      description: 'Formats the line numbers similar to Xcode. The theme will try to use the Xcode Digits typeface if installed.'
      type: 'boolean'
      default: true
    enableVibrancy:
      title: 'Enable vibrancy (experimental)'
      description: 'Sidebars will use vibrancy effects like other macOS apps. (This can become a performance issue if you typically have several Atom windows open at a time.)'
      type: 'boolean'
      default: true
    useProAppFocus:
      title: 'Highlight pane focus with outline (experimental)'
      description: 'When enabled, Atom will display a ring around the current pane or panel that has focus (similar to Pro Apps, like Logic Pro).'
      type: 'boolean'
      default: false
    showFilePathInStatusBar:
      title: 'Show file path in status bar'
      type: 'boolean'
      default: true
    clickThroughLinterMessages:
      title: 'Click through linter messages'
      description: 'Many linter messages contain a link to more information about the specified error. This option allows you to bypass links to move the cursor around the editor.'
      type: 'boolean'
      default: false
    useScrollLines:
      title: 'Use Xcode-like scroll lines (experimental)'
      description: 'Modify the minimap to simulate the scroll lines in Xcode. **You need to enable both Absolute Mode options in the minimap package.**'
      type: 'boolean'
      default: false

  activate: (state) ->
    atom.config.observe 'cupertino-ui.styleLineNumbers', ->
      body = document.body
      if atom.config.get('cupertino-ui.styleLineNumbers')
        addClass(body, 'cupertino-ui-style-line-numbers')
      else
        removeClass(body, 'cupertino-ui-style-line-numbers')
    atom.config.observe 'cupertino-ui.useProAppFocus', ->
      body = document.body
      if atom.config.get('cupertino-ui.useProAppFocus')
        addClass(body, 'cupertino-ui-pro-app-focus')
      else
        removeClass(body, 'cupertino-ui-pro-app-focus')
    atom.config.observe 'cupertino-ui.clickThroughLinterMessages', ->
      body = document.body
      if atom.config.get('cupertino-ui.clickThroughLinterMessages')
        addClass(body, 'cupertino-ui-click-through-tooltips')
      else
        removeClass(body, 'cupertino-ui-click-through-tooltips')
    atom.config.observe 'cupertino-ui.useScrollLines', ->
      body = document.body
      if atom.config.get('cupertino-ui.useScrollLines')
        addClass(body, 'cupertino-ui-use-scroll-lines')
      else
        removeClass(body, 'cupertino-ui-use-scroll-lines')
    atom.config.observe 'cupertino-ui.enableVibrancy', ->
      body = document.body
      if atom.config.get('cupertino-ui.enableVibrancy')
        addClass(body, 'cupertino-ui-enable-vibrancy')
      else
        removeClass(body, 'cupertino-ui-enable-vibrancy')
    atom.config.observe 'cupertino-ui.showFilePathInStatusBar', ->
      body = document.body
      if atom.config.get('cupertino-ui.showFilePathInStatusBar')
        removeClass(body, 'cupertino-ui-hide-file-path')
      else
        addClass(body, 'cupertino-ui-hide-file-path')
    atom.config.observe 'cupertino-ui.sidebarSize', ->
      body = document.body
      sidebarSize = atom.config.get('cupertino-ui.sidebarSize')
      removeClass(body, 'cupertino-ui-sidebar-size-small')
      removeClass(body, 'cupertino-ui-sidebar-size-medium')
      removeClass(body, 'cupertino-ui-sidebar-size-large')
      addClass(body, ('cupertino-ui-sidebar-size-' + sidebarSize))
