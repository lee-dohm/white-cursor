{WorkspaceView} = require 'atom'

describe 'White Cursor', ->
  beforeEach ->
    atom.workspaceView = new WorkspaceView
    atom.workspace = atom.workspaceView.model

    waitsForPromise -> atom.packages.activatePackage('white-cursor')
    runs -> atom.workspaceView.attachToDom()

  describe 'toggle command', ->
    it 'toggles the white cursor', ->
      workspace = atom.workspaceView
      workspace.removeClass('white-cursor')

      atom.workspaceView.trigger 'white-cursor:toggle'
      expect(workspace.hasClass('white-cursor')).toBeTruthy()

      atom.workspaceView.trigger 'white-cursor:toggle'
      expect(workspace.hasClass('white-cursor')).toBeFalsy()

  describe 'detect dark syntax', ->
    describe 'the test infrastructure', ->
      it 'does not have any themes by default', ->
        workspace = atom.workspaceView
        for name in workspace.attr('class').split(' ')
          expect(name).not.toMatch(/theme/)

    it 'adds the white-cursor class if a dark syntax theme is loaded', ->
      atom.workspaceView.addClass('theme-test-dark-syntax')
      atom.themes.emitter.emit('did-reload-all')

      expect(atom.workspaceView.hasClass('white-cursor')).toBeTruthy()

    it 'removes the white-cursor class if a dark syntax theme is unloaded', ->
      atom.workspaceView.addClass('white-cursor')
      atom.themes.emitter.emit('did-reload-all')

      expect(atom.workspaceView.hasClass('white-cursor')).toBeFalsy()

  describe 'configuration', ->
    it 'enables the white cursor if configuration is set to always', ->
      atom.config.set('white-cursor.enabled', 'always')
      atom.workspaceView.addClass('white-cursor')
      atom.themes.emitter.emit('did-reload-all')

      expect(atom.workspaceView.hasClass('white-cursor')).toBeTruthy()

    it 'disables the white cursor if configuration is set to never', ->
      atom.config.set('white-cursor.enabled', 'never')
      atom.workspaceView.addClass('theme-test-dark-syntax')
      atom.themes.emitter.emit('did-reload-all')

      expect(atom.workspaceView.hasClass('white-cursor')).toBeFalsy()
