// cane

// Because I won't remember any of this shit:

// - `$ => foo` is a closure (arrow function) with a parameter named literally `$`
// - First grammar rule is entry point
// - tree-sitter uses `$.foo` names as convention
// - Leading _ removes node from tree (becomes its own child)

// Builtins:
// - `seq` match sequence of rules in exact order
// - `choice` choose one rule
// - `repeat` zero or more
// - `repeat1` one or more
// - `optional` zero or one

const delimiter =
  String.raw`\p{White_Space}\p{Default_Ignorable_Code_Point}\[\];"`;

module.exports = grammar({
  name: 'cane',
  extras: _ => [/\p{White_Space}/],

  rules: {
    program: $ => repeat(choice($._expression, $.comment)),
    _expression: $ => choice($.word, $.quote, $.lookup, $.string, $.array),

    comment: _ => /;.*/,

    // words cannot begin with a sigil
    word: _ => new RustRegex(String.raw`[^${delimiter}'&][^${delimiter}]*`),

    // Sigils that modify the meaning of a word. Used for parsing `'` and `&`.
    // Basically, these rules create an explicit node for quote/lookup
    // _on top_ of the word node itself.
    // i.e. `'foo` = `(quote (word "foo"))` instead of `(quote "foo")`.
    quote: $ => seq("'", $.word),
    lookup: $ => seq('&', $.word),

    string: _ => /"([^"\\]|\\.)*"/,
    array: $ => seq('[', repeat($._expression), ']'),
  },
});
