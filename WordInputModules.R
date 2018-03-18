wordInputUI <- function(id) {
  ns = NS(id)

  uiOutput(outputId = ns("input_terms"))
}

wordInput <- function(input, output, session,
                      words,
                      label,
                      selected_words = '') {
  output$input_terms <- renderUI({
    selectInput(inputId = session$ns("input_terms"),
                label = label,
                choices = words,
                selected = selected_words,
                multiple = TRUE,
                selectize = TRUE)
  })

  input_terms = reactive({input$input_terms})

  return(input_terms)
}
