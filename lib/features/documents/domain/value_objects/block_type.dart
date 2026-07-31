/// Value Object: Document Block Type enum and utility extensions.
library;

/// Represents all supported block kinds in the block-based editor.
enum BlockType {
  /// Top-level H1 heading block.
  heading1,

  /// Sub-heading H2 block.
  heading2,

  /// Section heading H3 block.
  heading3,

  /// Standard rich-text paragraph block.
  paragraph,

  /// Unordered bullet point item block.
  bulletList,

  /// Ordered numbered list item block.
  numberedList,

  /// Grid data table block.
  table,

  /// Formatted code snippet block with syntax highlighting metadata.
  code,

  /// Stylized blockquote element.
  quote,

  /// High-visibility callout box with icon and container fill.
  callout,

  /// Embedded image asset block with caption support.
  image,

  /// Visual section divider line block.
  divider,

  /// Checkbox task list item block.
  todoList,
}

/// Extension methods for [BlockType] formatting and visual hints.
extension BlockTypeX on BlockType {
  /// Returns a human-readable display label for UI menus.
  String get label => switch (this) {
        BlockType.heading1 => 'Heading 1',
        BlockType.heading2 => 'Heading 2',
        BlockType.heading3 => 'Heading 3',
        BlockType.paragraph => 'Paragraph',
        BlockType.bulletList => 'Bullet List',
        BlockType.numberedList => 'Numbered List',
        BlockType.table => 'Table Grid',
        BlockType.code => 'Code Snippet',
        BlockType.quote => 'Quote',
        BlockType.callout => 'Callout Box',
        BlockType.image => 'Image Asset',
        BlockType.divider => 'Divider Line',
        BlockType.todoList => 'To-Do Checkbox',
      };

  /// Markdown prefix character syntax for text serialisation.
  String get markdownPrefix => switch (this) {
        BlockType.heading1 => '# ',
        BlockType.heading2 => '## ',
        BlockType.heading3 => '### ',
        BlockType.paragraph => '',
        BlockType.bulletList => '- ',
        BlockType.numberedList => '1. ',
        BlockType.table => '',
        BlockType.code => '```',
        BlockType.quote => '> ',
        BlockType.callout => '💡 ',
        BlockType.image => '![',
        BlockType.divider => '---',
        BlockType.todoList => '- [ ] ',
      };
}
