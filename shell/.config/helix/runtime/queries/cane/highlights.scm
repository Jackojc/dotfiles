(comment) @comment

["[" "]"] @punctuation.bracket

(string) @string

((word) @constant.numeric
  (#match? @constant.numeric "^[-+]?[0-9]+(/[0-9]+)?$"))

((word) @constant.numeric
  (#match? @constant.numeric "^0[bm][01]+$"))

[(quote) (lookup)] @string.special.symbol

(ERROR) @error
