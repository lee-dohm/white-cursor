WhiteCursor = require '../lib/white-cursor'

describe 'White Cursor', ->
  [workspaceElement] = []

  beforeEach ->
    workspaceElement = atom.views.getView(atom.workspace)
    jasmine.attachToDOM(workspaceElement)

    waitsForPromise -> atom.packages.activatePackage('white-cursor')

  describe 'toggle command', ->
    it 'toggles the white cursor', ->
      workspaceElement.classList.remove('white-cursor')

      atom.commands.dispatch(workspaceElement, 'white-cursor:toggle')
      expect(workspaceElement).toMatchSelector('.white-cursor')

      atom.commands.dispatch(workspaceElement, 'white-cursor:toggle')
      expect(workspaceElement).not.toMatchSelector('.white-cursor')

  describe 'detect dark syntax', ->
    beforeEach ->
      atom.config.set('white-cursor.enabled', 'detect')

    describe 'the test infrastructure', ->
      it 'does not have any themes by default', ->
        for name in workspaceElement.classList
          expect(name).not.toMatch(/theme/)

    it 'adds the white-cursor class if a dark syntax theme is loaded', ->
      workspaceElement.classList.add('theme-test-dark-syntax')
      atom.themes.emitter.emit('did-change-active-themes')

      expect(workspaceElement).toMatchSelector('.white-cursor')

    it 'removes the white-cursor class if a dark syntax theme is unloaded', ->
      workspaceElement.classList.add('white-cursor')
      atom.themes.emitter.emit('did-change-active-themes')

      expect(workspaceElement).not.toMatchSelector('.white-cursor')

  describe 'configuration', ->
    it 'enables the white cursor if configuration is set to always', ->
      atom.config.set('white-cursor.enabled', 'always')
      workspaceElement.classList.remove('white-cursor')
      atom.themes.emitter.emit('did-change-active-themes')

      expect(workspaceElement).toMatchSelector('.white-cursor')

    it 'disables the white cursor if configuration is set to never', ->
      atom.config.set('white-cursor.enabled', 'never')
      workspaceElement.classList.add('theme-test-dark-syntax')
      atom.themes.emitter.emit('did-change-active-themes')

      expect(workspaceElement).not.toMatchSelector('.white-cursor')

    it 'enables the white cursor if a theme matches the configuration', ->
      atom.config.set 'white-cursor',
        enabled: 'detect'
        darkThemes: ['test-theme']

      workspaceElement.classList.add('theme-test-theme')
      atom.themes.emitter.emit('did-change-active-themes')

      expect(workspaceElement).toMatchSelector('.white-cursor')

    it 'disables the white cursor if never is set even if a theme matches configuration', ->
      atom.config.set 'white-cursor',
        enabled: 'never'
        darkThemes: ['test-theme']

      workspaceElement.classList.add('theme-test-theme')
      atom.themes.emitter.emit('did-change-active-themes')

      expect(workspaceElement).not.toMatchSelector('.white-cursor')

    it 'updates if the enabled configuration option is changed', ->
      atom.config.set('white-cursor.enabled', 'never')
      workspaceElement.classList.add('theme-test-dark-syntax')
      atom.themes.emitter.emit('did-change-active-themes')

      expect(workspaceElement).not.toMatchSelector('.white-cursor')

      atom.config.set('white-cursor.enabled', 'always')

      expect(workspaceElement).toMatchSelector('.white-cursor')

    it 'updates if the dark themes list is changed', ->
      spyOn(WhiteCursor, 'update')

      atom.config.set('white-cursor.darkThemes', ['foo'])

      expect(WhiteCursor.update).toHaveBeenCalled()
