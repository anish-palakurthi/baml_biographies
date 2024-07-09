// This is a BAML config file, which extends the Jinja2 templating language to write LLM functions.
class Biography {
  name string @alias(#"first_name"#)
  surname string @alias(#"last_name"#)
  birth_place string 
  biography string 
}

function GenerateBiographies(person_count: int) -> Biography[] {
  // see clients.baml
  client GPT35

  // The prompt uses Jinja syntax. Change the models or this text and watch the prompt preview change!
  prompt #"
    Generate {{person_count}} sample biographies in the following format:

    {# special macro to print the output instructions. #}
    {{ ctx.output_format }}

    JSON:
  "#
}

test Test1 {
  functions [GenerateBiographies]
  args {
    person_count 3
  }
}