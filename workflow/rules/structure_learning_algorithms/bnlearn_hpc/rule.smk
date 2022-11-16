rule bnlearn_hpc:
    input:
        data=alg_input_data(),
    output:
        adjmat=alg_output_adjmat_path("bnlearn_hpc"),
        time=alg_output_time_path("bnlearn_hpc"),
        ntests=alg_output_ntests_path("bnlearn_hpc"),
    container:
        "docker://onceltuca/bnlearn:4.7"
    script:
        "bnlearn_hpc.R"
