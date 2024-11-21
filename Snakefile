# -*- mode: snakemake -*-
configfile: "config.yml"

rule all:
    "The default rule"
    input:
        fig_summary = "results/fig_summary.png",
        fig_individual = expand("results/fig_{country_code}.png",
                                country_code=config["country_codes"])

for country_code in config["country_codes"]:
    rule:
        name: f"transform_{country_code}"
        params:
            country_code=f"{country_code}"
        input:
            script = "1-transform.R",
            input_data = "data/WHO-COVID-19-global-data.csv"
        output:
            plot_data = f"intermediates/plot_df_{country_code}.csv"
        shell: """
        mkdir -p intermediates results
        Rscript {input.script} {input.input_data} {params.country_code} {output.plot_data}
        """

rule plot_individual:
    "Make a plot for an individual country"
    input:
        script = "2-plot.R",
        input_data = "intermediates/plot_df_{country_code}.csv"
    output:
        output_figure = "results/fig_{country_code}.png"
    shell: """
    Rscript {input.script} {input.input_data} {output.output_figure}
    """

rule plot_summary:
    "Make a summary plot"
    input:
        script = "3-plot-sum.R",
        input_data = [f"intermediates/plot_df_{country_code}.csv" for country_code in config["country_codes"]]
    output:
        output_figure = "results/fig_summary.png"
    shell: """
    Rscript {input.script} {output.output_figure} {input.input_data}
    """

rule dag:
    "Visualise the dag plot of the pipeline"
    output:
        output_figure = "dag.png"
    shell: """
    snakemake --dag | dot -Tpng > {output.output_figure}
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
    if [ -f dag.png ]; then
      rm dag.png
    fi
    """
