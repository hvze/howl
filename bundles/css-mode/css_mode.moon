-- Copyright 2013 Nils Nordman <nino at nordman.org>
-- License: MIT (see LICENSE.md)

import formatting from howl

class CSSMode
  new: =>
    @lexer = bundle_load 'css_lexer'
    completer = bundle_load 'css_completer'
    @completers = { completer, 'in_buffer' }

  default_config:
    word_pattern: '[-_%w]+'

  indent_patterns: {
    authoritive: true
    '{%s*$',
  }

  dedent_patterns: {
    authoritive: true
    '%s*}%s*$',
  }

  on_char_added: (args, editor) =>
    if args.key_name == 'return'
      return true if formatting.ensure_block editor, '{%s*$', '^%s*}'

    @parent.on_char_added @, args, editor