# Public: Handles activation and deactivation of the package.
class WhiteCursor
  config:
    darkThemes:
      type: 'array'
      default: []
      description: 'List of syntax theme names or partial names to categorize as dark on
                    auto-detection, in case they do not contain the word "dark" in them.'
      items:
        type: 'string'
    enabled:
      type: 'string'
      default: 'always'
      enum: ['always', 'detect', 'never']

  # Private: Name of the class to indicate whether the white cursor should be used.
  className: 'white-cursor'

  # Private: Subscription to the `atom.config.onDidChange` event.
  configChanged: null

  # Private: Subscription to the `atom.themes.onDidReloadAll` event.
  themesReloaded: null

  # Public: Activates the package.
  activate: ->
    @themesReloaded ?= atom.themes.onDidChangeActiveThemes =>
      @update()

    @command = atom.commands.add 'atom-workspace', 'white-cursor:toggle', =>
      @toggle()

    @configChanged ?= atom.config.onDidChange 'white-cursor.enabled', =>
      @update()

    @darkThemesChanged ?= atom.config.onDidChange 'white-cursor.darkThemes', =>
      @update()

    paneAdded = atom.workspace.onDidAddPane =>
      @update()
      paneAdded.dispose()

  # Public: Deactivates the package.
  deactivate: ->
    @command.dispose()
    @command = null

    @themesReloaded.dispose()
    @themesReloaded = null

    @configChanged.dispose()
    @configChanged = null

    @darkThemesChanged.dispose()
    @darkThemesChanged = null

    @remove()

  # Private: Unconditionally adds the `white-cursor` class to the workspace.
  add: ->
    @workspaceElement().classList.add(@className)

  # Private: Indicates if the workspace has a dark syntax theme.
  #
  # Returns a {Boolean} indicating whether the current syntax theme is "dark".
  hasDarkSyntaxTheme: ->
    classNames = @workspaceElement().className
    regexps = (new RegExp(themeName) for themeName in atom.config.get('white-cursor.darkThemes'))
    for name in classNames.split(' ')
      continue unless /theme/.test(name)

      if /syntax/.test(name) and /dark/.test(name)
        return true

      for regex in regexps
        if regex.test(name)
          return true

    return false

  # Private: Unconditionally removes the class from the workspace.
  remove: ->
    @workspaceElement().classList.remove(@className)

  # Private: Toggles whether the class is attached to the workspace.
  toggle: ->
    @workspaceElement().classList.toggle(@className)

  # Private: Updates the workspace to have the class, if appropriate.
  update: ->
    switch
      when atom.config.get('white-cursor.enabled') is 'always' then @add()
      when atom.config.get('white-cursor.enabled') is 'never' then @remove()
      when @hasDarkSyntaxTheme() then @add()
      else @remove()

  # Private: Returns a reference to the workspace DOM element.
  workspaceElement: ->
    atom.views.getView(atom.workspace)

module.exports = new WhiteCursor()
