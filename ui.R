ui <- fluidPage(
  textInput("word", "Word:", "city"),
  tableOutput("word_result"),

  textInput("formula", "Word Formula:", "budget - good"),
  verbatimTextOutput("formula_result"),

  textInput("analogy", "Word Analogy:", "blah"),
  verbatimTextOutput("analogy_result")
)
