rule all:
    "The default rule"
    input: "results/fig-simple.png"

rule transform:
    "Transform raw data"
    input:
        "data/WHO-COVID-19-global-data.csv"
    output: "intermediates/plot_df.csv"
    shell: """
    mkdir -p intermediates results
    Rscript 1-transform.R
    """

rule plot:
    "Make a simple plot"
    input:
        "intermediates/plot_df.csv"
    output: "results/fig-simple.png"
    shell: """
    Rscript 2-plot.R
    """

rule clean:
    "Clean up"
    shell: """
    if [ -d intermediates ]; then
      rm -r intermediates
    else
      echo directory intermediates does not exist
    fi
    if [ -d results ]; then
      rm -r results
    else
      echo directory results does not exist
    fi
    """
