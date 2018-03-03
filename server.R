server <- function(input, output) {
  model = wordVectors::read.vectors("word_embeddings.bin")

  output$word_result <- renderTable({
    query = input$word
    wordVectors::closest_to(model, query)
  })

  output$formula_result <- renderText({
    model[[input$formula]]
  })

  output$analogy_result <- renderText({
    model[[input$analogy]]
  })
}
