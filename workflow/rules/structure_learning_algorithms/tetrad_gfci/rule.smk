rule tetrad_gfci:
    input:
        data=alg_input_data(),
    output:
        adjmat=alg_output_adjmat_path("tetrad_gfci"),
        time=alg_output_time_path("tetrad_gfci"),
        ntests=touch(alg_output_ntests_path(module_name))
    container:
        "docker://onceltuca/causal-cmd:1.1.3"
    script:
        "tetrad_gfci.py"