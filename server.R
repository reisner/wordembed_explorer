# Convert
#    king - man + woman
# to
#    ~"king" - "man" + "woman"
processQuery <- function(query) {
  query_str = ''
  parts = unlist(strsplit(query, ' '))
  operators = c('+', '-', '*', '/')
  for (part in parts) {
    if (part %in% operators) {
      query_str = paste(query_str, part)
    } else {
      query_str = paste0(query_str, ' "', part, '"')
    }
  }
  paste0("~", query_str)
}

# ----- Server

server <- function(input, output) {
  model = wordVectors::read.vectors("word_embeddings.bin")
  query_words = row.names(model)
  exclude_words_ind = which(query_words %in% '</s>')
  query_words = query_words[-exclude_words_ind]

  # ------ Single Word Query
  word_query_result = callModule(wordInput,
                                 'word_query',
                                 words = query_words,
                                 label = 'Concept',
                                 selected_words = 'city')

  # ------ Word Formula

  word_formula_result = reactive({
    query = processQuery(input$word_formula)
    as.formula(query)
  })


  # ------ Query by Analogy
  analogy_a_result = callModule(wordInput,
                                'analogy_a',
                                words = query_words,
                                label = '',
                                selected_words = 'rec')
  analogy_b_result = callModule(wordInput,
                                'analogy_b',
                                words = query_words,
                                label = '',
                                selected_words = 'fun')
  analogy_c_result = callModule(wordInput,
                                'analogy_c',
                                words = query_words,
                                label = '',
                                selected_words = 'edmonton')
  word_analogy_result = reactive({
    query_a = analogy_a_result()
    query_b = analogy_b_result()
    query_c = analogy_c_result()
    req(query_a)
    req(query_b)
    req(query_c)
    query_str = paste0('~"', query_b, '" - "', query_a, '" + "', query_c, '"')
    formula = as.formula(query_str)
    eval(formula)
  })


  # ------ Query Builder
  builder_pos_terms = callModule(wordInput,
                                 'builder_pos_terms',
                                 words = query_words,
                                 label = 'Include Concepts',
                                 selected_words = 'city')
  builder_neg_terms = callModule(wordInput,
                                 'builder_neg_terms',
                                 words = query_words,
                                 label = 'Exclude Concepts',
                                 selected_words = 'waste')
  word_query_builder_result = reactive({
    pos_terms = builder_pos_terms()
    neg_terms = builder_neg_terms()

    req(!is.null(pos_terms) | !is.null(neg_terms))
    pos_present = !is.null(pos_terms)
    neg_present = !is.null(neg_terms)

    if (pos_present & neg_present) {
      model[[pos_terms]] - model[[neg_terms]]
    } else if (pos_present) {
      model[[pos_terms]]
    } else {
      -model[[neg_terms]]
    }
  })

  # ------ Query by text

  text_query_result = reactive({
    text = trimws(input$text_query)
    req(text)
    text = gsub("[[:punct:][:blank:]]+", " ", text)
    strsplit(text, "\\s+")[[1]]
  })


  # ------ Query Result
  output$query_result = renderTable({
    query_type = input$query_type
    query = ''
    if (query_type == 'word_query') {
      query = word_query_result()
      req(query)
    } else if (query_type == 'word_analogy') {
      query = word_analogy_result()
    } else if (query_type == 'word_formula') {
      query = word_formula_result()
    } else if (query_type == 'word_query_builder') {
      query = word_query_builder_result()
    } else if (query_type == 'query_by_text') {
      query = text_query_result()
    }
    wordVectors::closest_to(model, query)
  })
}
