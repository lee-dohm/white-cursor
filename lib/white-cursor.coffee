# Handles activation and deactivation of the package.
class WhiteCursor
  # Private: Name of the class to indicate whether the white cursor should be used.
  className: 'white-cursor'

  # Private: Subscription to the `atom.themes.onDidReloadAll` event.
  themesReloaded: null

  # Public: Activates the package.
  activate: ->
    @themesReloaded ?= atom.themes.onDidReloadAll =>
      @update()

    atom.workspaceView.command 'white-cursor:toggle', =>
      @toggle()

    paneAdded = atom.workspace.onDidAddPane =>
      @update()
      paneAdded.dispose()

  # Public: Deactivates the package.
  deactivate: ->
    @themesReloaded.dispose()
    @themesReloaded = null
    @remove()

  # Private: Unconditionally adds the `white-cursor` class to the workspace.
  add: ->
    @workspace().classList.add(@className)

  # Private: Indicates if the workspace has a dark syntax theme.
  hasDarkSyntaxTheme: ->
    classNames = @workspace().className
    for name in classNames.split(' ')
      if /theme/.test(name) and /syntax/.test(name) and /dark/.test(name)
        return true

    return false

  # Private: Unconditionally removes the `white-cursor` class from the workspace.
  remove: ->
    @workspace().classList.remove(@className)

  # Private: Toggles whether the `white-cursor` class is attached to the workspace.
  toggle: ->
    @workspace().classList.toggle(@className)

  # Private: Updates the workspace to have the `white-cursor` class, if appropriate.
  update: ->
    if @hasDarkSyntaxTheme() then @add() else @remove()

  # Private: Returns a reference to the workspace DOM element.
  workspace: ->
    document.querySelector('.workspace')

module.exports = new WhiteCursor()